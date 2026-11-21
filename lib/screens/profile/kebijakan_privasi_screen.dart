import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class KebijakanPrivasiScreen extends StatelessWidget {
  const KebijakanPrivasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final infoDikumpulkan = [
      'Nama lengkap',
      'Nomor telepon',
      'Alamat email',
      'Informasi akun pengguna',
      'Informasi pemesanan dan perjalanan',
      'Informasi pembayaran yang diperlukan untuk proses transaksi',
      'Informasi yang diberikan pengguna saat menggunakan fitur rekomendasi perjalanan',
    ];

    final penggunaanInfo = [
      'Memproses dan mengelola pemesanan perjalanan.',
      'Mengirimkan informasi terkait pemesanan dan perjalanan.',
      'Membantu pengguna mendapatkan rekomendasi perjalanan berdasarkan kebutuhan dan preferensi yang diberikan.',
      'Memberikan layanan bantuan kepada pengguna.',
      'Meningkatkan kualitas, keamanan, dan pengalaman penggunaan aplikasi.',
      'Menghubungi pengguna apabila terdapat informasi penting terkait layanan.',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Header Tetap (Tombol Back sejajar lurus dengan teks judul "Kebijakan Privasi")
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
                      'Kebijakan Privasi',
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

      // 2. Konten Scrollable dengan Card di Atas Latar Putih Bersih
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Card 1: Pembuka Kebijakan Privasi
          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      LucideIcons.shieldCheck,
                      size: 16,
                      color: Color(0xFF0077CC),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'KEBIJAKAN PRIVASI',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Terakhir diperbarui: 30 September 2026',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(height: 1),
                ),
                Text(
                  'Kebijakan Privasi ini menjelaskan bagaimana aplikasi kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pengguna saat menggunakan layanan pemesanan perjalanan.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    height: 1.55,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dengan menggunakan aplikasi ini, pengguna dianggap telah membaca dan memahami kebijakan privasi yang berlaku.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    height: 1.55,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Card 2: Poin 1 - Informasi yang Kami Kumpulkan
          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Informasi yang Kami Kumpulkan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Kami dapat mengumpulkan beberapa informasi yang diberikan oleh pengguna, antara lain:',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    height: 1.55,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ...infoDikumpulkan.map((item) => _buildBulletItem(item)),
                const SizedBox(height: 8),
                Text(
                  'Kami hanya mengumpulkan informasi yang diperlukan untuk menyediakan dan meningkatkan layanan aplikasi.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    height: 1.55,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Card 3: Poin 2 - Penggunaan Informasi
          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2. Penggunaan Informasi',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Informasi pengguna dapat digunakan untuk:',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    height: 1.55,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ...penggunaanInfo.map((item) => _buildBulletItem(item)),
              ],
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