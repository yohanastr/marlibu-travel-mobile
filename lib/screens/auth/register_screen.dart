
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Future<void> Function(Map<String, String> data)? onRegister;
  final Future<void> Function()? onGoogleSignIn;
  final VoidCallback? onLoginTap;

  const RegisterScreen({
    super.key,
    this.onRegister,
    this.onGoogleSignIn,
    this.onLoginTap,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirm = true;
  bool _loading = false;
  bool _submitted = false;

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  TextStyle get labelStyle => GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF252525),
      );

  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Wajib diisi';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Wajib diisi';
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$')
        .hasMatch(value.trim())) {
      return 'Email tidak valid';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wajib diisi';
    }

    if (value.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(value) ||
        !RegExp(r'[a-z]').hasMatch(value) ||
        !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password tidak memenuhi kriteria';
    }

    return null;
  }

  String? confirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wajib diisi';
    }

    if (value != _password.text) {
      return 'Password tidak sama';
    }

    return null;
  }

  InputDecoration decoration({
    String? hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 10,
        color: const Color(0xFF9CA3AF),
      ),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      suffixIcon: suffix,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 35,
        minHeight: 35,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFD5DDE5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
      errorStyle: const TextStyle(
        fontSize: 0,
        height: 0,
      ),
    );
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required String hint,
    String? helper,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    VoidCallback? toggle,
  }) {
    final invalid =
        _submitted && validator(controller.text) != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),

        const SizedBox(height: 4),

        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboard,
            obscureText: obscure,
            validator: validator,
            onChanged: (_) {
              if (_submitted) {
                setState(() {});
              }
            },
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppColors.textPrimary,
            ),
            decoration: decoration(
              hint: hint,
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (invalid)
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 17,
                    ),

                  if (toggle != null)
                    IconButton(
                      onPressed: toggle,
                      padding: EdgeInsets.zero,

                      // PERBAIKAN UKURAN ICON PASSWORD
                      constraints: const BoxConstraints.tightFor(
                        width: 35,
                        height: 35,
                      ),

                      visualDensity: VisualDensity.compact,
                      splashRadius: 16,

                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),

                  if (invalid && toggle == null)
                    const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),

        if (helper != null) ...[
          const SizedBox(height: 4),
          Text(
            helper,
            style: GoogleFonts.poppins(
              fontSize: 8,
              color: const Color(0xFF718096),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> goToLogin() async {
    if (widget.onLoginTap != null) {
      widget.onLoginTap!();
      return;
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  Future<void> handleRegister() async {
    FocusScope.of(context).unfocus();

    setState(() => _submitted = true);

    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      if (widget.onRegister != null) {
        await widget.onRegister!({
          'name': _name.text.trim(),
          'username': _username.text.trim(),
          'email': _email.text.trim(),
          'password': _password.text,
          'password_confirmation': _confirm.text,
        });
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registrasi berhasil. Silakan masuk.',
          ),
          backgroundColor: AppColors.success,
        ),
      );

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      if (mounted) await goToLogin();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrasi gagal: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> handleGoogleSignIn() async {
    if (widget.onGoogleSignIn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Google Sign-In belum dihubungkan.',
          ),
        ),
      );
      return;
    }

    try {
      await widget.onGoogleSignIn!();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In gagal: $e'),
        ),
      );
    }
  }

  Widget googleButton() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: OutlinedButton(
        onPressed: _loading ? null : handleGoogleSignIn,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(
            color: Color(0xFFD5DDE5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'G',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Daftar dengan Google',
              style: GoogleFonts.poppins(
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width =
                (MediaQuery.of(context).size.width * 0.73)
                    .clamp(260.0, 380.0);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: SizedBox(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 35,
                        bottom: 24,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daftar Akun',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF4B5568),
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            'Bergabung dengan Marlibu dan rencanakan liburanmu',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4B5568),
                            ),
                          ),

                          const SizedBox(height: 17),

                          Center(
                            child: Image.asset(
                              'assets/images/marlibu_logo.png',
                              width: 122,
                              height: 75,
                              fit: BoxFit.contain,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(
                              18,
                              18,
                              18,
                              16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F2FF),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),

                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  buildField(
                                    label: 'Nama Lengkap',
                                    controller: _name,
                                    hint: 'Masukkan nama lengkap',
                                    validator: requiredValidator,
                                  ),

                                  const SizedBox(height: 10),

                                  buildField(
                                    label: 'Username',
                                    controller: _username,
                                    hint: 'Buat username',
                                    validator: requiredValidator,
                                  ),

                                  const SizedBox(height: 10),

                                  buildField(
                                    label: 'Email',
                                    controller: _email,
                                    hint: 'contoh@gmail.com',
                                    keyboard:
                                        TextInputType.emailAddress,
                                    validator: emailValidator,
                                  ),

                                  const SizedBox(height: 10),

                                  buildField(
                                    label: 'Password',
                                    controller: _password,
                                    hint: 'Buat password',
                                    obscure: _hidePassword,
                                    validator: passwordValidator,
                                    helper:
                                        'Minimal 8 karakter, huruf besar, kecil, dan angka.',
                                    toggle: () => setState(
                                      () => _hidePassword =
                                          !_hidePassword,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  buildField(
                                    label: 'Konfirmasi Password',
                                    controller: _confirm,
                                    hint: 'Ulangi password',
                                    obscure: _hideConfirm,
                                    validator: confirmValidator,
                                    helper:
                                        'Masukkan kembali password yang sama.',
                                    toggle: () => setState(
                                      () => _hideConfirm =
                                          !_hideConfirm,
                                    ),
                                  ),

                                  const SizedBox(height: 14),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: _loading
                                          ? null
                                          : handleRegister,
                                      style:
                                          ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFFF8A3D),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                      ),
                                      child: _loading
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child:
                                                  CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'Daftar Sekarang',
                                              style:
                                                  GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight:
                                                    FontWeight.w700,
                                              ),
                                            ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Divider(
                                          color: Color(0xFFD5DDE5),
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
                                            fontSize: 8,
                                            color: AppColors
                                                .textSecondary,
                                          ),
                                        ),
                                      ),

                                      const Expanded(
                                        child: Divider(
                                          color: Color(0xFFD5DDE5),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 9),

                                  googleButton(),

                                  const SizedBox(height: 11),

                                  Center(
                                    child: Wrap(
                                      alignment:
                                          WrapAlignment.center,
                                      children: [
                                        Text(
                                          'Sudah punya akun? ',
                                          style: GoogleFonts.poppins(
                                            fontSize: 8,
                                            color:
                                                AppColors.textPrimary,
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: goToLogin,
                                          child: Text(
                                            'Masuk di sini',
                                            style:
                                                GoogleFonts.poppins(
                                              fontSize: 8,
                                              fontWeight:
                                                  FontWeight.w700,
                                              color:
                                                  AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
