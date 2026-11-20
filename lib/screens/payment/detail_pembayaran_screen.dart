import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'status_pembayaran_screen.dart';

class DetailPembayaranScreen extends StatefulWidget {
  final String metode;
  final String totalBayar;
  const DetailPembayaranScreen({
    super.key,
    required this.metode,
    this.totalBayar = 'Rp 455.000',
  });

  @override
  State<DetailPembayaranScreen> createState() => _DetailPembayaranScreenState();
}

class _DetailPembayaranScreenState extends State<DetailPembayaranScreen> {
  String _selectedBank = 'BCA';
  PlatformFile? _pickedFile;
  bool _showError = false;
  String _errorMessage = 'Upload bukti pembayaran terlebih dahulu sebelum konfirmasi.';

  static const _bankRekening = {
    'BCA': '1234-5678-910',
    'Mandiri': '1370-0987-6543',
    'BNI': '0987-6543-210',
    'BRI': '0029-0100-1234-501',
  };

  String get _appBarTitle => widget.metode == 'Qris'
      ? 'Via Qris'
      : widget.metode == 'Dana'
          ? 'Bayar Via Dana'
          : 'Transfer Bank';

  void _copy(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$label berhasil disalin ($text)', style: GoogleFonts.poppins(fontSize: 12)),
      backgroundColor: const Color(0xFF0077CC),
      duration: const Duration(seconds: 2),
    ));
  }

  Future<void> _pickFile() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (files.isEmpty) return;

    final file = files.first;
  final int fileSize = (await file.length()) ?? 0;
    // Validasi ukuran maksimal 5MB (5 * 1024 * 1024 bytes)
    if (fileSize > 5 * 1024 * 1024) {
      setState(() {
        _pickedFile = null;
        _showError = true;
        _errorMessage = 'Ukuran file melebihi batas maksimal 5MB.';
      });
      return;
    }

    setState(() {
      _pickedFile = file;
      _showError = false;
      _errorMessage = 'Upload bukti pembayaran terlebih dahulu sebelum konfirmasi.';
    });
  }

  void _handleKonfirmasi() {
    if (_pickedFile == null) {
      return setState(() {
        _showError = true;
        _errorMessage = 'Upload bukti pembayaran terlebih dahulu sebelum konfirmasi.';
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StatusPembayaranScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUploaded = _pickedFile != null;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.black, size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(_appBarTitle, style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (widget.metode == 'Qris') _buildQrisCard(),
          if (widget.metode == 'Dana') _buildDanaCard(),
          if (widget.metode == 'Transfer Bank') _buildBankCard(),
          const SizedBox(height: 22),

          // Upload Bukti Pembayaran (Membuka File Explorer / Galeri Asli)
          _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(9)),
                child: const Icon(LucideIcons.upload, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Upload Bukti Pembayaran', style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF2D3748))),
                  Text('JPG, PNG, Atau PDF. Maks. 5MB', style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF718096))),
                ]),
              ),
            ]),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickFile,
              child: CustomPaint(
                painter: _DashedRectPainter(color: isUploaded ? const Color(0xFF0077CC) : const Color(0xFF4A5568)),
                child: Container(
                  height: 155,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isUploaded ? const Color(0xFFF0F7FF) : const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (!isUploaded) ...[
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF22C55E)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(LucideIcons.image, color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 12),
                      Text('Tap Untuk Upload Screenshot', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF4A5568))),
                    ] else ...[
                      const Icon(LucideIcons.fileCheck2, color: Color(0xFF0077CC), size: 42),
                      const SizedBox(height: 10),
                      Text(
                        _pickedFile!.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0077CC)),
                      ),
                      const SizedBox(height: 4),
                      Text('Tap untuk mengganti file', style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF718096))),
                    ],
                  ]),
                ),
              ),
            ),
          ])),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Pembayaran akan diverifikasi dalam 1x24 jam.\nKonfirmasi pesanan akan dikirim melalui notifikasi.',
              style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF4A5568), height: 1.4),
            ),
          ),
          const SizedBox(height: 16),

          if (_showError) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDE8E8),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF87171), width: 1.2),
              ),
              child: Row(children: [
                const Icon(LucideIcons.info, color: Color(0xFFDC2626), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      'Bukti pembayaran belum valid',
                      style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFFDC2626)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _errorMessage,
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFFDC2626), height: 1.3),
                    ),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 16),
          ],

          SizedBox(
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isUploaded ? const Color(0xFFFF8A3D) : const Color(0xFFD9D9D9),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: _handleKonfirmasi,
              child: Text(
                'Upload Bukti Pembayaran',
                style: GoogleFonts.poppins(color: isUploaded ? Colors.white : const Color(0xFF4A5568), fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildQrisCard() => _card(
        Column(children: [
          Text('Scan Qris Di Bawah Ini', style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF4A5568))),
          const SizedBox(height: 18),
          const Icon(LucideIcons.qrCode, size: 210, color: Colors.black),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(16)),
            child: Center(child: Text('ID Transaksi: JNT-QR-H6QFO0', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.bold, color: const Color(0xFF4A5568)))),
          ),
        ]),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      );

  Widget _buildDanaCard() => _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 54,
            height: 44,
            decoration: _innerBox(),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(LucideIcons.wallet, size: 20, color: Color(0xFF118EEA)),
              Text('DANA', style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.bold, color: const Color(0xFF118EEA))),
            ]),
          ),
          const SizedBox(width: 14),
          Text('Bayar Via Dana', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF4A5568))),
        ]),
        const SizedBox(height: 16),
        _accountBox('Nomor Dana', '0811-2345-6789'),
        const SizedBox(height: 14),
        _totalBox(widget.totalBayar),
        const SizedBox(height: 14),
        Text('Transfer Nominal Unik & Tepat Agar Verifikasi\nOtomatis Berhasil', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF4A5568), height: 1.4)),
      ]));

  Widget _buildBankCard() {
    const banks = [
      ('BCA', Color(0xFF00529C)),
      ('Mandiri', Color(0xFF003D79)),
      ('BNI', Color(0xFFE55300)),
      ('BRI', Color(0xFF00529C)),
    ];
    return _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Pilih Bank Tujuan', style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF4A5568))),
      const SizedBox(height: 14),
      Row(
        children: banks.map((b) {
          final isSelected = _selectedBank == b.$1;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedBank = b.$1),
              child: Container(
                height: 44,
                margin: EdgeInsets.only(right: b.$1 == 'BRI' ? 0 : 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? const Color(0xFF0077CC) : Colors.transparent, width: 1.5),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 3))],
                ),
                child: Center(
                  child: Text(b.$1, style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.bold, color: b.$2)),
                ),
              ),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 16),
      _accountBox('Nomor Rekening $_selectedBank', _bankRekening[_selectedBank]!),
      const SizedBox(height: 14),
      _totalBox(widget.totalBayar),
      const SizedBox(height: 14),
      Text('Transfer Nominal Unik & Tepat Agar Verifikasi\nOtomatis Berhasil', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF4A5568), height: 1.4)),
    ]));
  }

  Widget _accountBox(String title, String number) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: _innerBox(),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF718096))),
              const SizedBox(height: 2),
              Text(number, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF2D3748))),
              const SizedBox(height: 2),
              Text('a.n. Marlibo Travel', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF718096))),
            ]),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _copy(number, title),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFF2B7AC0), borderRadius: BorderRadius.circular(14)),
              child: Text('Salin', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ]),
      );

  Widget _totalBox(String amount) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: _innerBox(),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total Transfer', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF718096))),
          Text(amount, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF2D3748))),
        ]),
      );

  Widget _card(Widget child, {EdgeInsetsGeometry padding = const EdgeInsets.all(18)}) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), spreadRadius: 1, blurRadius: 15, offset: const Offset(0, 4))],
        ),
        child: child,
      );

  BoxDecoration _innerBox() => BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 3))],
      );
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  _DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final path = Path()..addRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14)));
    for (final m in path.computeMetrics()) {
      for (double d = 0.0; d < m.length; d += 10.0) {
        canvas.drawPath(m.extractPath(d, (d + 5.0).clamp(0.0, m.length)), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter old) => old.color != color;
}