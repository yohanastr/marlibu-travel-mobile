import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import halaman OTP dan Kata Sandi Baru
import 'otp_verification_screen.dart'; 
import 'kata_sandi_baru_screen.dart';

class LupaPasswordScreen extends StatefulWidget {
  final Future<void> Function(String email)? onSendOtp;
  final VoidCallback? onBackToLogin;

  const LupaPasswordScreen({
    super.key,
    this.onSendOtp,
    this.onBackToLogin,
  });

  @override
  State<LupaPasswordScreen> createState() => _LupaPasswordScreenState();
}

class _LupaPasswordScreenState extends State<LupaPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  static const Color primaryBlue = Color(0xFF0874B9);
  static const Color orange = Color(0xFFFF914D);
  static const Color textColor = Color(0xFF71829F);
  static const Color cardColor = Color(0xFFF5F5F5);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // ==========================================
  // VALIDASI EMAIL
  // ==========================================
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Alamat email wajib diisi';
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // ==========================================
  // PROSES KIRIM OTP & NAVIGASI
  // ==========================================
  Future<void> _handleSendOtp() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.onSendOtp != null) {
        await widget.onSendOtp!(email);
      } else {
        // Simulasi loading sebentar jika API belum disambungkan
        await Future.delayed(const Duration(milliseconds: 1000));
      }

      // SETELAH BERHASIL, NAVIGASI KE HALAMAN OTP
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              email: email, // Kirim email ke halaman OTP
              
              // ==========================================
              // LOGIKA PINDAH OTOMATIS KE KATA SANDI BARU
              // ==========================================
              onVerify: () {
                // Gunakan pushReplacement agar user tidak bisa kembali (back) ke OTP
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KataSandiBaruScreen(),
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengirim kode OTP: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ==========================================
  // KEMBALI KE LOGIN
  // ==========================================
  void _handleBack() {
    if (widget.onBackToLogin != null) {
      widget.onBackToLogin!();
    } else {
      Navigator.pop(context);
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
                // MENGGUNAKAN ALIGN TOP CENTER SEPERTI OTP DAN KATA SANDI BARU
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 420,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32, 
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ==================================
                          // JARAK BAGIAN ATAS DISAMAKAN DENGAN OTP (0.15)
                          // ==================================
                          SizedBox(
                            height: screenHeight * 0.15, 
                          ),

                          // ==================================
                          // KEMBALI KE LOGIN
                          // ==================================
                          GestureDetector(
                            onTap: _handleBack,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  color: primaryBlue,
                                  size: 17,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Kembali ke Login',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 4),

                          // ==================================
                          // JUDUL
                          // ==================================
                          Text(
                            'Lupa Kata Sandi',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 3),

                          // ==================================
                          // DESKRIPSI
                          // ==================================
                          Text(
                            'Masukkan alamat email yang terdaftar. '
                            'Kami akan mengirimkan kode OTP untuk '
                            'mengatur ulang kata sandi Anda.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ==================================
                          // CARD EMAIL
                          // ==================================
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // LABEL EMAIL
                                  Text(
                                    'Alamat Email Terdaftar',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF4B5870),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // INPUT EMAIL
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    validator: _validateEmail,
                                    onFieldSubmitted: (_) {
                                      _handleSendOtp();
                                    },
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: const Color(0xFF4B5870),
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true, 
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 11, 
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFD5DCE5),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFD5DCE5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: primaryBlue,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 27),

                          // ==================================
                          // TOMBOL KIRIM OTP
                          // ==================================
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 19,
                                      height: 19,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Kirim Kode OTP',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
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