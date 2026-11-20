import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'detail_perjalanan_screen.dart';

class CariTravelScreen extends StatelessWidget {
  const CariTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Off White
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          // Menggunakan ikon panah kiri dari Lucide
          icon: const Icon(LucideIcons.chevronLeft, color: Color(0xFF4A5568), size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keberangkatan yang Tersedia',
              style: GoogleFonts.poppins(
                color: const Color(0xFF4A5568),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Perjalanan nyaman, harga bersahabat',
              style: GoogleFonts.poppins(
                color: const Color(0xFF4A5568),
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        children: [
          _buildJadwalCard(context, '07 Oktober 2026', 'Siang : 11.00', 'Sore : 15.00', 'Rp90.000'),
          _buildJadwalCard(context, '08 Oktober 2026', 'Pagi : 06.00', 'Siang : 14.00', 'Rp160.000'),
          _buildJadwalCard(context, '09 Oktober 2026', 'Pagi : 07.00', 'Sore : 16.00', 'Rp100.000'),
          _buildJadwalCard(context, '10 Oktober 2026', 'Pagi : 06.00', 'Siang : 14.00', 'Rp185.000'),
          _buildJadwalCard(context, '15 Oktober 2026', 'Pagi : 06.00', 'Siang : 14.00', 'Rp150.000'),
        ],
      ),
    );
  }

  Widget _buildJadwalCard(BuildContext context, String tanggal, String waktuBerangkat, String waktuTiba, String harga) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // BARIS 1: KOTA KEBERANGKATAN & TUJUAN
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keberangkatan',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 12, color: const Color(0xFF4A5568)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Jakarta',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: const Color(0xFF4A5568)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tujuan',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 12, color: const Color(0xFF4A5568)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Yogyakarta',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: const Color(0xFF4A5568)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const Divider(height: 24, thickness: 1, color: Color(0xFF4A5568)),
          
          // BARIS 2: TANGGAL & HARGA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menggunakan ikon kalender dari Lucide
                  const Icon(LucideIcons.calendar, size: 18, color: Color(0xFF4A5568)),
                  const SizedBox(width: 8),
                  Text(
                    '$tanggal\n8 jam',
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF4A5568), height: 1.3),
                  ),
                ],
              ),
              Text(
                harga,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: const Color(0xFF4A5568)),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // BARIS 3: WAKTU & TOMBOL BOOKING
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menggunakan ikon jam dari Lucide
                  const Icon(LucideIcons.clock, size: 18, color: Color(0xFF4A5568)),
                  const SizedBox(width: 8),
                  Text(
                    '$waktuBerangkat\n$waktuTiba',
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF4A5568), height: 1.3),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8A3D), // Accent Orange
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPerjalananScreen()));
                  },
                  child: Text(
                    'Booking',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}