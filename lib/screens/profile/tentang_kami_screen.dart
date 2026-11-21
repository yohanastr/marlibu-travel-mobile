import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'syarat_ketentuan_screen.dart';
import 'kebijakan_privasi_screen.dart';

class TentangKamiScreen extends StatelessWidget {
  const TentangKamiScreen({super.key});

  // Fungsi transisi halaman mulus (Slide halus dari kanan + Fade)
  void _navigateSmooth(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.08, 0.0), // Geser tipis dari kanan
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Header Tetap (Senada dengan Kebijakan Privasi & Syarat Ketentuan)
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
                      'Tentang Kami',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Cari Tahu Tentang Layanan Kami',
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

      // 2. Konten Scrollable dengan Desain Tetap & Card Konsisten
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const SizedBox(height: 16),

          // Logo Marlibu Tour and Travel (Tanpa Kotak/Pinggiran, Hanya Shading)
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 14,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/marlibu_logo.png',
                  height: 95,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          const SizedBox(height: 36),

          // Card Tentang Aplikasi (Teks Rata Kanan-Kiri / Justify)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TENTANG APLIKASI',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Jelajah Nusantara Travel adalah platform pemesanan travel terpercaya yang melayani rute antarkota di seluruh Indonesia. Kami hadir sejak 2015 untuk memudahkan perjalananmu dengan armada yang nyaman, aman, dan terjangkau.',
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

          const SizedBox(height: 32),

          // Statistik (37 Rute Perjalanan & 20 Armada Aktif) dengan Border Biru
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatBox(
                number: '37',
                label: 'Rute Perjalanan',
              ),
              const SizedBox(width: 28),
              _buildStatBox(
                number: '20',
                label: 'Armada Aktif',
              ),
            ],
          ),

          const SizedBox(height: 36),

          // Card Menu dengan Efek Sentuhan Halus + Transisi Mulus
          Container(
            width: double.infinity,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    children: [
                      _buildMenuTile(
                        title: 'Syarat dan Ketentuan',
                        onTap: () => _navigateSmooth(
                          context,
                          const SyaratKetentuanScreen(),
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey[200],
                      ),
                      _buildMenuTile(
                        title: 'Kebijakan Privasi',
                        onTap: () => _navigateSmooth(
                          context,
                          const KebijakanPrivasiScreen(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatBox({required String number, required String label}) {
    return Container(
      width: 115,
      height: 105,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1F8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF1E88E5),
          width: 1.2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: GoogleFonts.poppins(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFFF8A34),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFFFA866),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: const Color(0xFF1E88E5).withOpacity(0.12),
      highlightColor: const Color(0xFFEAF1F8).withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}