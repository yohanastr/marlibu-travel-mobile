import 'package:flutter/material.dart';
import '../payment/pilih_metode_bayar_screen.dart';

typedef UnitKendaraan = Map<String, dynamic>;

class RingkasanPrivateTripScreen extends StatefulWidget {
  final String namaKota;
  final int hargaPaketAngka;
  final List<String> destinasiDipilih;
  final UnitKendaraan unit;
  final String titikJemput;
  final String linkMaps;
  final DateTime? tanggalJemput;
  final String jamJemput;

  const RingkasanPrivateTripScreen({
    super.key,
    required this.namaKota,
    required this.hargaPaketAngka,
    required this.destinasiDipilih,
    required this.unit,
    this.titikJemput = 'Titik Jemput',
    this.linkMaps = '',
    this.tanggalJemput,
    this.jamJemput = '08:00 WIB',
  });

  @override
  State<RingkasanPrivateTripScreen> createState() =>
      _RingkasanPrivateTripScreenState();
}

class _RingkasanPrivateTripScreenState
    extends State<RingkasanPrivateTripScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _promoController = TextEditingController();

  late DateTime _tanggalTrip;
  int _jumlahPeserta = 2;
  double _diskonPersen = 0.0;
  String? _promoInfo;

  @override
  void initState() {
    super.initState();
    _tanggalTrip =
        widget.tanggalJemput ?? DateTime.now().add(const Duration(days: 3));
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hpController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  String _formatRupiah(int angka) {
    final str = angka.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final reverseIndex = str.length - i;
      if (i > 0 && reverseIndex % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return 'Rp ${buffer.toString()}';
  }

  String _formatTanggal(DateTime date) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${bulan[date.month - 1]} ${date.year}';
  }

  void _cekKodePromo(String val) {
    final kode = val.trim().toUpperCase();
    setState(() {
      if (kode == 'WEEKEND20') {
        _diskonPersen = 0.20;
        _promoInfo = 'Diskon 20% berhasil diterapkan!';
      } else if (kode == 'NEWYEAR') {
        _diskonPersen = 0.50;
        _promoInfo = 'Diskon 50% berhasil diterapkan!';
      } else {
        _diskonPersen = 0.0;
        _promoInfo = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int hargaUnit = widget.unit['hargaAngka'] as int;
    final int subtotalPaket = widget.hargaPaketAngka * _jumlahPeserta;
    final int subtotal = subtotalPaket + hargaUnit;
    final int potongan = (subtotal * _diskonPersen).round();
    final int totalBayar = subtotal - potongan;

    final String daftarDestinasiText = widget.destinasiDipilih.isEmpty
        ? 'Semua Destinasi Unggulan'
        : widget.destinasiDipilih.join(', ');

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER "< Ringkasan Booking"
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 20, 10),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF0F172A),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Ringkasan Booking',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),

            // KONTEN KARTU RINGKASAN
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
                child: Column(
                  children: [
                    // CARD 1: PAKET & TITIK JEMPUT PRIVATE TRIP
                    _buildCardContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Paket & Penjemputan Private Trip',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.jamJemput,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    const Text(
                                      'JEMPUT',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0066B2),
                                      ),
                                    ),
                                    Text(
                                      widget.titikJemput,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10.5,
                                        color: Color(0xFF475569),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Private Trip',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF334155),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Icon(
                                      Icons.directions_car_outlined,
                                      size: 20,
                                      color: Color(0xFF0066B2),
                                    ),
                                    Container(
                                      width: 72,
                                      height: 1.5,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      color: const Color(0xFF0066B2),
                                    ),
                                    Text(
                                      _formatTanggal(_tanggalTrip),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10.5,
                                        color: Color(0xFF475569),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Tujuan',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    Text(
                                      widget.namaKota
                                          .substring(0, 3)
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0066B2),
                                      ),
                                    ),
                                    Text(
                                      widget.namaKota,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10.5,
                                        color: Color(0xFF475569),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 18, color: Color(0xFFE2E8F0)),
                          Text(
                            'Destinasi: $daftarDestinasiText',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.5,
                              color: Color(0xFF334155),
                            ),
                          ),
                          if (widget.linkMaps.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Maps: ${widget.linkMaps}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: Color(0xFF0066B2),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // CARD 2: KENDARAAN & KAPASITAS
                    _buildCardContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Kendaraan & Kapasitas',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                widget.unit['nama'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.unit['plat'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  color: Color(0xFF334155),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Kapasitas',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.unit['kursi'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0066B2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // CARD 3: DATA PEMESAN & KODE PROMO
                    _buildCardContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Pemesan',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildTextField(
                            controller: _namaController,
                            hint: 'Masukkan nama lengkap',
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Nomor HP',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildTextField(
                            controller: _hpController,
                            hint: 'Masukkan nomor HP',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 12),

                          // Jumlah Peserta
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Jumlah Peserta',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: _jumlahPeserta > 1
                                        ? () =>
                                            setState(() => _jumlahPeserta--)
                                        : null,
                                    icon: const Icon(
                                      Icons.remove_circle_outline_rounded,
                                      color: Color(0xFF0066B2),
                                    ),
                                  ),
                                  Text(
                                    '$_jumlahPeserta Orang',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        setState(() => _jumlahPeserta++),
                                    icon: const Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: Color(0xFF0066B2),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Masukkan Kode Promo
                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Text(
                                  'Masukkan Kode Promo',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 36,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: _promoController,
                                    onChanged: _cekKodePromo,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Cth : WEEKEND20',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        color: Color(0xFF94A3B8),
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 9),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_promoInfo != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              _promoInfo!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // CARD 4: RINCIAN HARGA
                    _buildCardContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rincian Harga',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Paket ${widget.namaKota} ($_jumlahPeserta Orang)',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                _formatRupiah(subtotalPaket),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Unit ${widget.unit['nama']}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                _formatRupiah(hargaUnit),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                          if (potongan > 0) ...[
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Diskon Promo',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.5,
                                    color: Color(0xFF16A34A),
                                  ),
                                ),
                                Text(
                                  '- ${_formatRupiah(potongan)}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF16A34A),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const Divider(height: 20, color: Color(0xFFE2E8F0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                _formatRupiah(totalBayar),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // SYARAT DAN KETENTUAN
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 16,
                            color: Color(0xFF60A5FA),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Syarat dan Ketentuan Private Trip berlaku',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // TOMBOL LANJUT KE PEMBAYARAN
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_namaController.text.trim().isEmpty ||
                              _hpController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Harap isi Nama Lengkap dan Nomor HP terlebih dahulu',
                                ),
                              ),
                            );
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PilihMetodeBayarScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7A00),
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Lanjut ke Pembayaran',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11.5,
            color: Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}