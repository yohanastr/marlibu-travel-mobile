import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SyaratKetentuanScreen extends StatelessWidget {
  const SyaratKetentuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final termsList = [
      {
        'number': '1',
        'title': 'Pemesanan',
        'points': [
          'Pemesanan otomatis batal jika melewati batas waktu pembayaran.',
        ],
      },
      {
        'number': '2',
        'title': 'Keberangkatan',
        'points': [
          'Mohon siap 30 menit sebelum jam keberangkatan.',
        ],
      },
      {
        'number': '3',
        'title': 'Reschedule & Pembatalan',
        'points': [
          'Perubahan jadwal (reschedule) dapat dilakukan maksimal 24 jam sebelum berangkat.',
        ],
      },
      {
        'number': '4',
        'title': 'Bagasi & Keamanan',
        'points': [
          'Dilarang membawa barang berbahaya, sajam, atau narkoba ke dalam bagasi.',
          'Kehilangan barang berharga pribadi bukan tanggung jawab pihak travel.',
        ],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Header Tetap (Senada dengan Kebijakan Privasi & tombol back sejajar judul)
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 72,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(top: 1.0, right: 10.0),
                  child: Icon(
                    LucideIcons.chevronLeft,
                    color: Colors.black,
                    size: 26,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Syarat dan Ketentuan',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Jangan lewatkan info tentang liburanmu',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // 2. Konten Scrollable dengan Card Putih Ber-shading (Senada Kebijakan Privasi)
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Header Sub-judul Layanan
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 14.0),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.fileText,
                  size: 16,
                  color: Color(0xFF0077CC),
                ),
                const SizedBox(width: 6),
                Text(
                  'SYARAT & KETENTUAN MARLIBU TRAVEL',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          // Daftar Card per Poin dengan Shading Halus
          ...termsList.map((item) {
            final number = item['number'] as String;
            final title = item['title'] as String;
            final points = item['points'] as List<String>;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$number. $title',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...points.map((point) => _buildBulletItem(point)),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: child,
      );

  Widget _buildBulletItem(String text) => Padding(
        padding: const EdgeInsets.only(left: 6.0, bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.5, right: 8.0),
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFF0077CC),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
}