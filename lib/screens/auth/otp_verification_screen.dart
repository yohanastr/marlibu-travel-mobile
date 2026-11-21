import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final VoidCallback? onVerify;
  final VoidCallback? onResend;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    this.onVerify,
    this.onResend,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  // ==========================================
  // VARIABEL & STATE
  // ==========================================
  static const Color primaryBlue = Color(0xFF0874B9);
  static const Color orange = Color(0xFFFF914D);
  static const Color textColor = Color(0xFF71829F);

  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  Timer? _timer;
  int _start = 59;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Menambahkan listener ke setiap focus node untuk me-rebuild UI (border warna biru/abu)
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // ==========================================
  // LOGIKA TIMER KODE OTP
  // ==========================================
  void _startTimer() {
    setState(() {
      _start = 59;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _canResend = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _handleResend() {
    if (_canResend) {
      if (widget.onResend != null) widget.onResend!();
      _startTimer();
    }
  }

  // ==========================================
  // LOGIKA INPUT OTP
  // ==========================================
  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Pindah ke kotak berikutnya jika ada input
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Otomatis verifikasi jika kotak terakhir terisi
        _focusNodes[index].unfocus();
        if (widget.onVerify != null) {
          widget.onVerify!();
        }
      }
    } else {
      // Kembali ke kotak sebelumnya jika dihapus
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  // ==========================================
  // BUILD HALAMAN
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 420,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Menyesuaikan jarak atas agar sejajar dengan desain
                          SizedBox(height: screenHeight * 0.15),

                          // ==================================
                          // JUDUL
                          // ==================================
                          Text(
                            'Verifikasi OTP',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ==================================
                          // DESKRIPSI (RichText untuk cetak tebal email)
                          // ==================================
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Kami telah mengirimkan 4-digit kode keamanan ke email ',
                                ),
                                TextSpan(
                                  text: widget.email,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF4B5870), // Warna teks email lebih gelap
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          // ==================================
                          // KOTAK INPUT OTP (4 Digit)
                          // ==================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              bool isActive = _focusNodes[index].hasFocus || _controllers[index].text.isNotEmpty;
                              
                              return Container(
                                width: 55,
                                height: 65,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isActive ? primaryBlue : const Color(0xFFD5DCE5),
                                    width: isActive ? 1.5 : 1.0,
                                  ),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: primaryBlue,
                                    ),
                                    decoration: const InputDecoration(
                                      counterText: '', // Menghilangkan teks counter (0/1)
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    onChanged: (value) => _onOtpChanged(value, index),
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 32),

                          // ==================================
                          // TOMBOL KIRIM ULANG & TIMER
                          // ==================================
                          Center(
                            child: GestureDetector(
                              onTap: _handleResend,
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: textColor,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Belum menerima kode? '),
                                    TextSpan(
                                      text: _canResend ? 'Kirim ulang' : 'Kirim ulang (${_start}s)',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: _canResend ? primaryBlue : orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}