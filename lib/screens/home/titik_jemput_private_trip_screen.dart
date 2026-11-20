import 'package:flutter/material.dart';
import 'ringkasan_private_trip_screen.dart';

typedef UnitKendaraan = Map<String, dynamic>;

class TitikJemputPrivateTripScreen extends StatefulWidget {
  final String namaKota;
  final int hargaPaketAngka;
  final List<String> destinasiDipilih;
  final UnitKendaraan unit;

  const TitikJemputPrivateTripScreen({
    super.key,
    required this.namaKota,
    required this.hargaPaketAngka,
    required this.destinasiDipilih,
    required this.unit,
  });

  @override
  State<TitikJemputPrivateTripScreen> createState() =>
      _TitikJemputPrivateTripScreenState();
}

class _TitikJemputPrivateTripScreenState
    extends State<TitikJemputPrivateTripScreen> {
  final TextEditingController _lokasiJemputController = TextEditingController();
  final TextEditingController _linkMapsController = TextEditingController();

  DateTime _tanggalJemput = DateTime.now().add(const Duration(days: 3));
  TimeOfDay _jamJemput = const TimeOfDay(hour: 8, minute: 0);

  @override
  void dispose() {
    _lokasiJemputController.dispose();
    _linkMapsController.dispose();
    super.dispose();
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

  String _formatJam(TimeOfDay time) {
    final jam = time.hour.toString().padLeft(2, '0');
    final menit = time.minute.toString().padLeft(2, '0');
    return '$jam:$menit WIB';
  }

  Future<void> _pilihTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalJemput,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 180)),
    );
    if (picked != null) {
      setState(() => _tanggalJemput = picked);
    }
  }

  Future<void> _pilihJam() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _jamJemput,
    );
    if (picked != null) {
      setState(() => _jamJemput = picked);
    }
  }

  void _lanjutKeRingkasan() {
    if (_lokasiJemputController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap masukkan lokasi atau alamat titik penjemputan'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RingkasanPrivateTripScreen(
          namaKota: widget.namaKota,
          hargaPaketAngka: widget.hargaPaketAngka,
          destinasiDipilih: widget.destinasiDipilih,
          unit: widget.unit,
          titikJemput: _lokasiJemputController.text.trim(),
          linkMaps: _linkMapsController.text.trim(),
          tanggalJemput: _tanggalJemput,
          jamJemput: _formatJam(_jamJemput),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER "< Detail Penjemputan" (Menyesuaikan gaya "< Detail Perjalanan")
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
                    'Detail Penjemputan',
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

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
                child: Column(
                  children: [
                    // CARD 1: BANNER BIRU LEMBUT RINGKASAN RUTE & UNIT (Seperti card atas Detail Perjalanan)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF3FA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _formatJam(_jamJemput),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
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
                                  const Text(
                                    'Lokasi Anda',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10.5,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    widget.unit['nama'],
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF334155),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Icon(
                                    Icons.directions_car_outlined,
                                    size: 20,
                                    color: Color(0xFF0066B2),
                                  ),
                                  Container(
                                    width: 76,
                                    height: 1.5,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    color: const Color(0xFF0066B2),
                                  ),
                                  Text(
                                    _formatTanggal(_tanggalJemput),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10.5,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Private',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // CARD 2: TITIK PENJEMPUTAN (Ikon Pin Merah seperti "Titik Keberangkatan")
                    _buildIconInputCard(
                      icon: Icons.location_on_outlined,
                      iconColor: const Color(0xFFEF4444),
                      title: 'Titik Penjemputan',
                      hint: 'Contoh: Stasiun Malang / Alamat Rumah',
                      controller: _lokasiJemputController,
                    ),
                    const SizedBox(height: 12),

                    // CARD 3: LINK GOOGLE MAPS (Opsional, persis placeholder di screenshot temanmu)
                    _buildIconInputCard(
                      icon: Icons.flag_outlined,
                      iconColor: const Color(0xFFEF4444),
                      title: 'Link Google Maps (Opsional)',
                      hint: 'Masukkan Link Google Maps',
                      controller: _linkMapsController,
                    ),
                    const SizedBox(height: 12),

                    // CARD 4: TANGGAL & JAM PENJEMPUTAN (Ikon Stopwatch/Kalender)
                    InkWell(
                      onTap: _pilihTanggal,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 24,
                              color: Color(0xFF0066B2),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tanggal Penjemputan',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF334155),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _formatTanggal(_tanggalJemput),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Ubah',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF7A00),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // CARD 5: JAM PENJEMPUTAN (Ikon Pink seperti "Durasi Perjalanan")
                    InkWell(
                      onTap: _pilihJam,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 24,
                              color: Color(0xFFEC4899),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Jam Penjemputan',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF334155),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _formatJam(_jamJemput),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Ubah',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF7A00),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // CARD HARGA UNIT RATA KANAN (Persis card "Harga Perorang" di kanan bawah)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Biaya Unit Kendaraan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.5,
                                color: Color(0xFF475569),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.unit['harga'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TOMBOL LANJUT KE RINGKASAN BOOKING
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: _lanjutKeRingkasan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7A00),
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Lanjut ke Ringkasan Booking',
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

  Widget _buildIconInputCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String hint,
    required TextEditingController controller,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFF0F172A),
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      color: Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 4, bottom: 2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}