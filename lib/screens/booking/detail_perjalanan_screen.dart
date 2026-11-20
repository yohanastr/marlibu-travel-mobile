import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'pilih_kursi_screen.dart';

class DetailPerjalananScreen extends StatefulWidget {
  const DetailPerjalananScreen({super.key});

  @override
  State<DetailPerjalananScreen> createState() => _DetailPerjalananScreenState();
}

class _DetailPerjalananScreenState extends State<DetailPerjalananScreen> {
  final TextEditingController _keberangkatanController = TextEditingController();
  final TextEditingController _kedatanganController = TextEditingController();

  bool get _isFormValid =>
      _keberangkatanController.text.trim().isNotEmpty &&
      _kedatanganController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _keberangkatanController.addListener(() => setState(() {}));
    _kedatanganController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _keberangkatanController.dispose();
    _kedatanganController.dispose();
    super.dispose();
  }

  void _handlePilihKursi() {
    if (!_isFormValid) {
      // Hapus snackbar sebelumnya jika user menekan tombol berkali-kali
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(LucideIcons.circleAlert, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Masukkan Link Google Maps terlebih dahulu',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFE53E3E),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PilihKursiScreen()),
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
        title: Text(
          'Detail Perjalanan',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CARD HEADER RUTE
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FA),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '06:00',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: const Color(0xFF4A5568),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'JKT',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: const Color(0xFF0077CC),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Jakarta',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color(0xFF4A5568),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Text(
                            '8 Jam',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: const Color(0xFF4A5568),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0077CC),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: Colors.white, thickness: 2.5),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.0),
                                child: Icon(
                                  LucideIcons.car,
                                  color: Color(0xFF3182CE),
                                  size: 22,
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: Colors.white, thickness: 2.5),
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF8A3D),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '10 September 2026',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: const Color(0xFF4A5568),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '14:00',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: const Color(0xFF4A5568),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'YGY',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: const Color(0xFF0077CC),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Yogyakarta',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color(0xFF4A5568),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // INPUT TITIK KEBERANGKATAN
            _buildInputCard(
              icon: const Icon(LucideIcons.mapPin, color: Color(0xFFE53E3E), size: 28),
              label: 'Titik Keberangkatan',
              controller: _keberangkatanController,
            ),

            const SizedBox(height: 18),

            // INPUT TITIK KEDATANGAN
            _buildInputCard(
              icon: const Icon(LucideIcons.flag, color: Color(0xFFE53E3E), size: 28),
              label: 'Titik Kedatangan',
              controller: _kedatanganController,
            ),

            const SizedBox(height: 18),

            // CARD KURSI TERSEDIA
            _buildInfoCard(
              icon: const Icon(LucideIcons.armchair, color: Color(0xFF718096), size: 28),
              label: 'Kursi Tersedia',
              value: '5 Dari 7',
            ),

            const SizedBox(height: 18),

            // CARD DURASI PERJALANAN
            _buildInfoCard(
              icon: const Icon(LucideIcons.timer, color: Color(0xFFED64A6), size: 28),
              label: 'Durasi Perjalanan',
              value: '8 Jam',
            ),

            const SizedBox(height: 45),

            // HARGA PERORANG
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Harga Perorang',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4A5568),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Rp 185.000',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // TOMBOL PILIH KURSI (TETAP BISA DIKLIK UNTUK VALIDASI)
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid
                      ? const Color(0xFFFF8A3D)
                      : const Color(0xFFD1D5DB),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _handlePilihKursi,
                child: Text(
                  'Pilih Kursi',
                  style: GoogleFonts.poppins(
                    color: _isFormValid ? Colors.white : const Color(0xFF4A5568),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required Widget icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4A5568),
                  ),
                ),
                const SizedBox(height: 2),
                TextField(
                  controller: controller,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF0077CC),
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Masukkan Link Google Maps',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.normal,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required Widget icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}