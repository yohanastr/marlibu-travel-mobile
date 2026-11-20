import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'detail_pembayaran_screen.dart';

class PilihMetodeBayarScreen extends StatefulWidget {
  final String totalBayar;
  const PilihMetodeBayarScreen({super.key, this.totalBayar = 'Rp 455.000'});

  @override
  State<PilihMetodeBayarScreen> createState() => _PilihMetodeBayarScreenState();
}

class _PilihMetodeBayarScreenState extends State<PilihMetodeBayarScreen> {
  String? _selectedMetode;
  bool _showError = false;

  void _handleLanjutBayar() {
    if (_selectedMetode == null) {
      setState(() => _showError = true);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPembayaranScreen(
          metode: _selectedMetode!,
          totalBayar: widget.totalBayar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = _selectedMetode != null;

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
        title: Text(
          _selectedMetode ?? 'Pilih Pembayaran',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Metode Pembayaran',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 14),
            _buildMetodeCard(
              title: 'Qris',
              subtitle: 'Scan QR Dari Aplikasi Manapun',
              iconWidget: const Icon(LucideIcons.qrCode, size: 32, color: Colors.black87),
            ),
            const SizedBox(height: 14),
            _buildMetodeCard(
              title: 'Dana',
              subtitle: 'Transfer Via Nomor Dana',
              iconWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.wallet, size: 22, color: Color(0xFF118EEA)),
                  Text(
                    'DANA',
                    style: GoogleFonts.poppins(
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF118EEA),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _buildMetodeCard(
              title: 'Transfer Bank',
              subtitle: 'BCA, Mandiri, BNI, BRI',
              iconWidget: const Icon(LucideIcons.landmark, size: 30, color: Color(0xFF2D3748)),
            ),
            const SizedBox(height: 26),
            Text(
              'Yang Perlu Disiapkan:',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildChecklistItem('Batas Waktu Pembayaran 24 Jam'),
                  const SizedBox(height: 12),
                  _buildChecklistItem('Upload Bukti Setelah Transfer'),
                  const SizedBox(height: 12),
                  _buildChecklistItem('Verifikasi 1x24 Jam Kerja'),
                ],
              ),
            ),
            const SizedBox(height: 36),
            if (_showError) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE8E8),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFF87171), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.info, color: Color(0xFFDC2626), size: 26),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Metode pembayaran belum dipilih',
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                          Text(
                            'Pilih salah satu metode pembayaran terlebih dahulu.',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
            Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFF8A3D).withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? const Color(0xFFFF8A3D) : const Color(0xFFD9D9D9),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: _handleLanjutBayar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lanjut Bayar',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF4A5568),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(LucideIcons.arrowRight, size: 20, color: Color(0xFF4A5568)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetodeCard({
    required String title,
    required String subtitle,
    required Widget iconWidget,
  }) {
    final bool isSelected = _selectedMetode == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMetode = title;
          _showError = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF0077CC) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 42, height: 42, child: Center(child: iconWidget)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF4A5568)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Row(
      children: [
        const Icon(LucideIcons.check, size: 18, color: Colors.black),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF4A5568)),
          ),
        ),
      ],
    );
  }
}