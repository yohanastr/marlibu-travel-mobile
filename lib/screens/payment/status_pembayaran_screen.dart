import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StatusPembayaranScreen extends StatefulWidget {
  final String kodeBooking;
  const StatusPembayaranScreen({super.key, this.kodeBooking = 'JNT-R0TE23'});

  @override
  State<StatusPembayaranScreen> createState() => _StatusPembayaranScreenState();
}

class _StatusPembayaranScreenState extends State<StatusPembayaranScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _circleScale;
  late final Animation<double> _checkProgress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // 1. Lingkaran hijau memantul halus di awal (0% - 55% durasi)
    _circleScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.55, curve: Curves.elasticOut),
    );

    // 2. Garis centang putih tergambar setelah lingkaran muncul (40% - 100% durasi)
    _checkProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 1.0, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _copyKode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.kodeBooking));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Kode booking ${widget.kodeBooking} berhasil disalin',
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        backgroundColor: const Color(0xFF0077CC),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Ikon Centang Hijau Beranimasi
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _circleScale.value,
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2ED573),
                          shape: BoxShape.circle,
                        ),
                        child: CustomPaint(
                          painter: _AnimatedCheckPainter(_checkProgress.value),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 22),

                // 2. Judul Booking Berhasil!
                Text(
                  'Booking Berhasil!',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),

                // 3. Subjudul
                Text(
                  'Perjalananmu sedang dikonfirmasi. Cek\nnotifikasi untuk detail booking.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF718096),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Kotak Kode Booking (#E8F1FA)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F1FA),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Kode Booking',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0077CC),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.kodeBooking,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 14),
                          GestureDetector(
                            onTap: () => _copyKode(context),
                            child: const Icon(LucideIcons.copy, size: 22, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // 5. Tombol Kembali Ke Beranda
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A3D),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                    child: Text(
                      'Kembali Ke Beranda',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF4A5568),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedCheckPainter extends CustomPainter {
  final double progress;
  _AnimatedCheckPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Titik jalur centang dari kiri -> bawah -> kanan atas
    final path = Path()
      ..moveTo(size.width * 0.29, size.height * 0.52)
      ..lineTo(size.width * 0.44, size.height * 0.67)
      ..lineTo(size.width * 0.72, size.height * 0.36);

    for (final metric in path.computeMetrics()) {
      final animatedPath = metric.extractPath(0.0, metric.length * progress);
      canvas.drawPath(animatedPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AnimatedCheckPainter oldDelegate) =>
      oldDelegate.progress != progress;
}