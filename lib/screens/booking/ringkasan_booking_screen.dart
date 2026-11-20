import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../payment/pilih_metode_bayar_screen.dart';

class RingkasanBookingScreen extends StatefulWidget {
  final List<int> selectedSeats;
  final int hargaPerKursi;

  const RingkasanBookingScreen({
    super.key,
    this.selectedSeats = const [4],
    this.hargaPerKursi = 185000,
  });

  @override
  State<RingkasanBookingScreen> createState() => _RingkasanBookingScreenState();
}

class _RingkasanBookingScreenState extends State<RingkasanBookingScreen> {
  final _namaController = TextEditingController();
  final _hpController = TextEditingController();
  final _promoController = TextEditingController();
  bool isAgreed = false, _showSubmitError = false;

  int get _jumlahKursi => widget.selectedSeats.isEmpty ? 1 : widget.selectedSeats.length;
  String get _kursiText => widget.selectedSeats.isEmpty ? '4' : widget.selectedSeats.join(', ');
  int get _hargaTiket => _jumlahKursi * widget.hargaPerKursi;
  bool get _hasPromo => _promoController.text.trim().isNotEmpty;
  int get _diskonPromo => _hasPromo ? 20000 : 0;
  int get _totalHarga => _hargaTiket - _diskonPromo;

  String _formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp $buffer';
  }

  bool get _isHpNumeric => RegExp(r'^[0-9]+$').hasMatch(_hpController.text.trim());
  String? get _hpError => _hpController.text.trim().isNotEmpty && !_isHpNumeric
      ? 'Nomor HP hanya boleh berisi angka'
      : null;
  bool get _isFormReady =>
      _namaController.text.trim().isNotEmpty &&
      _hpController.text.trim().isNotEmpty &&
      _isHpNumeric &&
      isAgreed;

  @override
  void initState() {
    super.initState();
    _namaController.addListener(_onChanged);
    _hpController.addListener(_onChanged);
    _promoController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {
        if (_isFormReady && _showSubmitError) _showSubmitError = false;
      });

  @override
  void dispose() {
    _namaController.dispose();
    _hpController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  String get _submitErrorMsg {
    if (_namaController.text.trim().isEmpty) return 'Masukkan nama lengkap terlebih dahulu sebelum melanjutkan.';
    if (_hpController.text.trim().isEmpty) return 'Masukkan nomor HP terlebih dahulu sebelum melanjutkan.';
    if (!_isHpNumeric) return 'Nomor HP tidak valid, hanya boleh dimasukkan angka.';
    return 'Centang persetujuan syarat & ketentuan terlebih dahulu.';
  }

  void _handleLanjut() {
    if (!_isFormReady) return setState(() => _showSubmitError = true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PilihMetodeBayarScreen(totalBayar: _formatRupiah(_totalHarga)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.black, size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Ringkasan Booking', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. Rute Perjalanan
          _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rute Perjalanan', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _cityCol('06:00', 'JKT', 'Jakarta'),
              Column(children: [
                Text('8 Jam', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF4A5568))),
                const SizedBox(height: 4),
                const Icon(LucideIcons.car, color: Color(0xFF3182CE), size: 20),
                Container(margin: const EdgeInsets.symmetric(vertical: 4), height: 2, width: 70, color: const Color(0xFF3182CE)),
                Text('10 September 2026', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF4A5568))),
              ]),
              _cityCol('14:00', 'YGY', 'Yogyakarta'),
            ]),
          ])),
          const SizedBox(height: 16),

          // 2. Kendaraan & Kursi
          _card(Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Kendaraan & Kursi', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 4),
              Text('Innova Reborn\nB 5675 ABC', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
            ]),
            Text('Kursi\n$_kursiText', textAlign: TextAlign.right, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ])),
          const SizedBox(height: 16),

          // 3. Data Penumpang & Promo
          _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Data Penumpang', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 12),
            Text('Nama Lengkap', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            _input(_namaController, 'Masukkan nama lengkap'),
            const SizedBox(height: 14),
            Text('Nomor HP', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            _input(_hpController, 'Masukkan nomor HP', isPhone: true, error: _hpError),
            if (_hpError != null)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: Row(children: [
                  const Icon(LucideIcons.circleAlert, size: 14, color: Color(0xFFDC2626)),
                  const SizedBox(width: 6),
                  Text(_hpError!, style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w500, color: const Color(0xFFDC2626))),
                ]),
              ),
            const SizedBox(height: 16),
            Row(children: [
              Text('Masukkan Kode Promo', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12.5)),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _promoController,
                  textCapitalization: TextCapitalization.characters,
                  style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.normal, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Cth : MARLIBUJOSJIS2',
                    hintStyle: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.grey.shade500),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
              ),
            ]),
          ])),
          const SizedBox(height: 16),

          // 4. Rincian Harga
          _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rincian Harga', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 12),
            _priceRow('Tiket ($_jumlahKursi Kursi)', _formatRupiah(_hargaTiket)),
            if (_hasPromo) _priceRow('Diskon Promo', '- Rp 20.000', valueColor: const Color(0xFF16A34A)),
            const Padding(padding: EdgeInsets.symmetric(vertical: 6), child: Divider()),
            _priceRow('Total', _formatRupiah(_totalHarga), isBold: true),
          ])),
          const SizedBox(height: 16),

          // 5. Syarat & Ketentuan
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.redAccent), borderRadius: BorderRadius.circular(14)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(LucideIcons.info, size: 16, color: Color(0xFF0077CC)),
                const SizedBox(width: 6),
                Text('Syarat dan Ketentuan', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.bold, color: Colors.black87)),
              ]),
              const SizedBox(height: 6),
              Text(
                '• Pengembalian dana 75% dari total pesanan\n'
                '• Pastikan hadir 1 jam sebelum keberangkatan\n'
                '• Dilarang bawa hewan/barang berbau yang mengganggu kenyamanan\n'
                '• Tarif penuh untuk anak usia 3 tahun ke atas\n'
                '• Konfirmasi titik jemput serta tujuan',
                style: GoogleFonts.poppins(fontSize: 10.5, color: Colors.black87, height: 1.5),
              ),
            ]),
          ),
          const SizedBox(height: 6),

          CheckboxListTile(
            title: Text('Saya telah membaca dan menyetujui syarat & Ketentuan yang berlaku', style: GoogleFonts.poppins(fontSize: 11, color: Colors.black87)),
            value: isAgreed,
            onChanged: (val) => setState(() {
              isAgreed = val ?? false;
              if (_isFormReady && _showSubmitError) _showSubmitError = false;
            }),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFFFF8A3D),
          ),
          const SizedBox(height: 12),

          // 6. Kotak Error & Tombol Lanjut
          if (_showSubmitError) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFDE8E8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFF87171), width: 1.2),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: Row(children: [
                const Icon(LucideIcons.info, color: Color(0xFFDC2626), size: 28),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Data pemesanan belum lengkap', style: GoogleFonts.poppins(fontSize: 14.5, fontWeight: FontWeight.bold, color: const Color(0xFFDC2626))),
                  const SizedBox(height: 2),
                  Text(_submitErrorMsg, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFFDC2626), height: 1.3)),
                ])),
              ]),
            ),
            const SizedBox(height: 16),
          ],

          SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormReady ? const Color(0xFFFF8A3D) : const Color(0xFFD1D5DB),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _handleLanjut,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Lanjut Ke Pembayaran', style: GoogleFonts.poppins(color: _isFormReady ? Colors.white : const Color(0xFF4A5568), fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 8),
                Icon(LucideIcons.arrowRight, size: 20, color: _isFormReady ? Colors.white : const Color(0xFF4A5568)),
              ]),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: child,
      );

  Widget _cityCol(String time, String code, String city) => Column(children: [
        Text(time, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(code, style: GoogleFonts.poppins(color: const Color(0xFF0077CC), fontWeight: FontWeight.bold, fontSize: 13)),
        Text(city, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF4A5568))),
      ]);

  Widget _input(TextEditingController ctrl, String hint, {bool isPhone = false, String? error}) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: error != null ? const BorderSide(color: Color(0xFFDC2626), width: 1.2) : BorderSide.none,
    );
    return TextField(
      controller: ctrl,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: Colors.grey.shade400),
        filled: true,
        fillColor: const Color(0xFFF7F8FA),
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false, Color? valueColor}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: GoogleFonts.poppins(fontSize: isBold ? 13.5 : 12.5, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.black87)),
          Text(value, style: GoogleFonts.poppins(fontSize: isBold ? 13.5 : 12.5, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: valueColor ?? Colors.black87)),
        ]),
      );
}