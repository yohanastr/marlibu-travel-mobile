import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lupa_password_screen.dart';
import '../home/home_screen.dart'; // Import halaman HomeScreen

class LoginScreen extends StatefulWidget {
  final Future<void> Function(Map<String, String> data)? onLogin;
  final Future<void> Function()? onGoogleSignIn;
  final VoidCallback? onForgotPasswordTap;

  const LoginScreen({
    super.key,
    this.onLogin,
    this.onGoogleSignIn,
    this.onForgotPasswordTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _obscurePassword = true;

  bool _usernameHasError = false;
  bool _passwordHasError = false;

  static const Color primaryBlue = Color(0xFF0874B9);
  static const Color lightBlue = Color(0xFFE4F2FF);
  static const Color orange = Color(0xFFFF914D);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // VALIDASI INPUT TANPA MENGUBAH UKURAN CARD

  bool _validateInputs() {
    setState(() {
      _usernameHasError =
          _usernameController.text.trim().isEmpty;

      _passwordHasError =
          _passwordController.text.isEmpty;
    });

    if (_usernameHasError || _passwordHasError) {
      String message;

      if (_usernameHasError && _passwordHasError) {
        message = 'Username dan kata sandi wajib diisi';
      } else if (_usernameHasError) {
        message = 'Username wajib diisi';
      } else {
        message = 'Kata sandi wajib diisi';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return false;
    }

    return true;
  }

  // PROSES LOGIN & NAVIGASI KE HOME

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    if (!_validateInputs()) return;

    setState(() => _isLoading = true);

    try {
      if (widget.onLogin != null) {
        await widget.onLogin!({
          'username': _usernameController.text.trim(),
          'password': _passwordController.text,
        });
      } else {
        // Simulasi proses login sebelum masuk ke HomeScreen
        await Future.delayed(const Duration(milliseconds: 800));
        
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // LOGIN GOOGLE

  Future<void> _handleGoogleSignIn() async {
    if (widget.onGoogleSignIn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google Sign-In belum dihubungkan.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.onGoogleSignIn!();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Google gagal: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // INPUT FIELD

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    required bool hasError,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
    VoidCallback? onVisibilityToggle,
    TextInputAction textInputAction = TextInputAction.next,
    FocusNode? focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onSubmitted: textInputAction == TextInputAction.next
                ? (_) => _passwordFocusNode.requestFocus()
                : (_) => _handleLogin(),
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              isDense: true,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),

              suffixIcon: onVisibilityToggle == null
                  ? null
                  : IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 38,
                        minHeight: 40,
                      ),
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 18,
                        color: const Color(0xFF64748B),
                      ),
                      onPressed: onVisibilityToggle,
                    ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : const Color(0xFFCBD5E1),
                  width: 1.0,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: hasError ? Colors.red : primaryBlue,
                  width: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // TOMBOL GOOGLE

  Widget _googleButton() {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: OutlinedButton(
        onPressed: _isLoading ? null : _handleGoogleSignIn,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1E293B),
          side: const BorderSide(
            color: Color(0xFFCBD5E1),
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'G',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4),
              ),
            ),

            const SizedBox(width: 8),

            Text(
              'Masuk dengan Google',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HALAMAN LOGIN

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = constraints.maxHeight;

            final cardWidth =
                (screenWidth * 0.78).clamp(250.0, 360.0);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight,
                ),

                child: SizedBox(
                  width: double.infinity,

                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.18),

                      // LOGO MARLIBU

                      Image.asset(
                        'assets/images/marlibu_logo.png',
                        width: screenWidth * 0.40,
                        height: screenHeight * 0.12,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // CARD LOGIN

                      Container(
                        width: cardWidth,

                        padding: const EdgeInsets.fromLTRB(
                          18,
                          20,
                          18,
                          18,
                        ),

                        decoration: BoxDecoration(
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            // USERNAME

                            _buildInput(
                              label: 'Username',
                              controller: _usernameController,
                              hasError: _usernameHasError,

                              onChanged: (value) {
                                if (value.trim().isNotEmpty &&
                                    _usernameHasError) {
                                  setState(() {
                                    _usernameHasError = false;
                                  });
                                }
                              },
                            ),

                            const SizedBox(height: 10),

                            // KATA SANDI

                            _buildInput(
                              label: 'Kata Sandi',
                              controller: _passwordController,
                              hasError: _passwordHasError,
                              obscureText: _obscurePassword,
                              focusNode: _passwordFocusNode,
                              textInputAction: TextInputAction.done,

                              onChanged: (value) {
                                if (value.isNotEmpty &&
                                    _passwordHasError) {
                                  setState(() {
                                    _passwordHasError = false;
                                  });
                                }
                              },

                              onVisibilityToggle: () {
                                setState(() {
                                  _obscurePassword =
                                      !_obscurePassword;
                                });
                              },
                            ),

                            const SizedBox(height: 7),

                            // LUPA KATA SANDI

                            Align(
                              alignment: Alignment.centerRight,

                              child: GestureDetector(
                                onTap: () {
                                  if (widget.onForgotPasswordTap != null) {
                                    widget.onForgotPasswordTap!();
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LupaPasswordScreen(),
                                      ),
                                    );
                                  }
                                },

                                child: Text(
                                  'Lupa kata sandi?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1E293B),
                                    decoration:
                                        TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // TOMBOL MASUK

                            SizedBox(
                              width: double.infinity,
                              height: 42,

                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : _handleLogin,

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: orange,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: EdgeInsets.zero,

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                ),

                                child: _isLoading
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child:
                                            CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'Masuk',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // PEMBATAS ATAU

                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Color(0xFFCBD5E1),
                                    thickness: 0.9,
                                  ),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 9,
                                  ),

                                  child: Text(
                                    'ATAU',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),

                                const Expanded(
                                  child: Divider(
                                    color: Color(0xFFCBD5E1),
                                    thickness: 0.9,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // LOGIN GOOGLE

                            _googleButton(),
                          ],
                        ),
                      ),
                    ],
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