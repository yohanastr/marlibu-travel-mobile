import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KataSandiBaruScreen extends StatefulWidget {
  const KataSandiBaruScreen({super.key});

  @override
  State<KataSandiBaruScreen> createState() => _KataSandiBaruScreenState();
}

class _KataSandiBaruScreenState extends State<KataSandiBaruScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isLoading = false;

  static const Color primaryBlue = Color(0xFF0874B9);
  static const Color orange = Color(0xFFFF914D);
  static const Color textColor = Color(0xFF71829F);
  static const Color cardColor = Color(0xFFF5F5F5); 

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulasi proses API (tunggu 2 detik)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kata sandi berhasil diubah! Silakan login.')),
      );

      // Kembali ke halaman Login (menghapus semua tumpukan halaman sebelumnya)
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

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
                          SizedBox(height: screenHeight * 0.15),

                          // ==================================
                          // JUDUL
                          // ==================================
                          Text(
                            'Kata Sandi Baru',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ==================================
                          // DESKRIPSI
                          // ==================================
                          Text(
                            'Buat kata sandi baru yang kuat dan mudah Anda ingat',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ==================================
                          // FORM KATA SANDI BARU (CARD)
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
                                  // LABEL KATA SANDI BARU
                                  Text(
                                    'Kata Sandi Baru',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF4B5870),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _isPasswordObscured,
                                    style: GoogleFonts.poppins(fontSize: 12),
                                    // AUTOU VALIDATE SAAT USER MENGETIK
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Kata sandi tidak boleh kosong';
                                      }
                                      if (value.length < 8) {
                                        return 'Minimal 8 karakter';
                                      }
                                      if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                                        return 'Harus mengandung huruf kecil (a-z)';
                                      }
                                      if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                                        return 'Harus mengandung huruf besar (A-Z)';
                                      }
                                      if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
                                        return 'Harus mengandung angka (0-9)';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Buat password',
                                      hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFFB0B8C1)),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                      // STYLING SAAT ERROR
                                      errorStyle: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.red,
                                        height: 1.2,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFFD5DCE5)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFFD5DCE5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: primaryBlue),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                          size: 18,
                                          color: const Color(0xFF71829F),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordObscured = !_isPasswordObscured;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 6),
                                  
                                  // KETERANGAN SANDI DI BAWAH KOTAK
                                  Text(
                                    'Minimal 8 karakter, huruf besar, kecil, dan angka.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: const Color(0xFF71829F),
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // LABEL ULANGI KATA SANDI BARU
                                  Text(
                                    'Ulangi Kata Sandi Baru',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF4B5870),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: _isConfirmPasswordObscured,
                                    style: GoogleFonts.poppins(fontSize: 12),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Konfirmasi kata sandi wajib diisi';
                                      }
                                      if (value != _passwordController.text) {
                                        return 'Kata sandi tidak cocok';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFFB0B8C1)),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                      // STYLING SAAT ERROR
                                      errorStyle: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.red,
                                        height: 1.2,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFFD5DCE5)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFFD5DCE5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: primaryBlue),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                          size: 18,
                                          color: const Color(0xFF71829F),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // ==================================
                          // TOMBOL ATUR ULANG KATA SANDI
                          // ==================================
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleResetPassword,
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
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Atur Ulang Kata Sandi',
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