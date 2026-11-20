import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'ringkasan_booking_screen.dart';

class PilihKursiScreen extends StatefulWidget {
  const PilihKursiScreen({super.key});

  @override
  State<PilihKursiScreen> createState() => _PilihKursiScreenState();
}

class _PilihKursiScreenState extends State<PilihKursiScreen> {
  final Set<String> _kursiTerisi = {'1', '7'};
  final Set<String> _kursiDipilih = {};
  final int _hargaPerKursi = 185000;

  String _formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp $buffer';
  }

  void _toggleKursi(String nomorKursi) {
    if (_kursiTerisi.contains(nomorKursi)) return;
    setState(() {
      if (_kursiDipilih.contains(nomorKursi)) {
        _kursiDipilih.remove(nomorKursi);
      } else {
        _kursiDipilih.add(nomorKursi);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSelected = _kursiDipilih.isNotEmpty;
    final int totalHarga = _kursiDipilih.length * _hargaPerKursi;

    final sortedSelected = _kursiDipilih.toList()
      ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pilih Kursi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 56),
                    Container(
                      padding: const EdgeInsets.fromLTRB(26, 18, 26, 32),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F8FA),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 16,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              'Depan Kendaraan',
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF4A5568),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSeatWidget('1'),
                              _buildDriverWidget(),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSeatWidget('2'),
                              _buildSeatWidget('3'),
                              _buildSeatWidget('4'),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSeatWidget('5'),
                              _buildSeatWidget('6'),
                              _buildSeatWidget('7'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem(color: const Color(0xFFE8F1FA), label: 'Tersedia'),
                        const SizedBox(height: 10),
                        _buildLegendItem(color: const Color(0xFF0A66C2), label: 'Dipilih'),
                        const SizedBox(height: 10),
                        _buildLegendItem(color: const Color(0xFFFF9B50), label: 'Terisi'),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hasSelected ? 'Pilih Kursi: ${sortedSelected.join(', ')}' : 'Pilih Kursi:',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      if (hasSelected)
                        Text(
                          _formatRupiah(totalHarga),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasSelected ? const Color(0xFFFF8A3D) : const Color(0xFFCCCCCC),
                        disabledBackgroundColor: const Color(0xFFCCCCCC),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: hasSelected
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RingkasanBookingScreen(
                                    selectedSeats: sortedSelected.map(int.parse).toList(),
                                    hargaPerKursi: _hargaPerKursi,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lanjut Ke Ringkasan',
                            style: GoogleFonts.poppins(
                              color: hasSelected ? Colors.white : const Color(0xFF334155),
                              fontWeight: FontWeight.bold,
                              fontSize: 15.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            LucideIcons.arrowRight,
                            size: 20,
                            color: hasSelected ? Colors.white : const Color(0xFF334155),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverWidget() {
    return Container(
      width: 66,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: const Center(child: Text('👨‍✈️', style: TextStyle(fontSize: 26))),
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2))],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w500, color: const Color(0xFF4A5568)),
        ),
      ],
    );
  }

  Widget _buildSeatWidget(String nomorKursi) {
    final bool isOccupied = _kursiTerisi.contains(nomorKursi);
    final bool isSelected = _kursiDipilih.contains(nomorKursi);

    Color bgColor = const Color(0xFFE8F1FA);
    Color textColor = const Color(0xFF2D3748);

    if (isOccupied) {
      bgColor = const Color(0xFFFF9B50);
    } else if (isSelected) {
      bgColor = const Color(0xFF0A66C2);
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: () => _toggleKursi(nomorKursi),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 66,
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Center(
          child: Text(
            nomorKursi,
            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
          ),
        ),
      ),
    );
  }
}