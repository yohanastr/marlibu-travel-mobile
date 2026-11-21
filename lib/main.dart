import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

// Halaman bagian Splash & Auth
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/lupa_password_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'screens/auth/kata_sandi_baru_screen.dart';

// Halaman bagian Profile
import 'screens/profile/profile_screen.dart';
import 'screens/profile/pengaturan_screen.dart';
import 'screens/profile/pusat_bantuan_screen.dart';
import 'screens/profile/tentang_kami_screen.dart';
import 'screens/profile/syarat_ketentuan_screen.dart';
import 'screens/profile/kebijakan_privasi_screen.dart';
import 'screens/profile/ajukan_refund_screen.dart';
import 'screens/profile/logout_screen.dart';

// Halaman bagian Booking (Yohana)
import 'screens/booking/cari_travel_screen.dart';

// Halaman bagian Main Layout, Home & History (Novi)
import 'screens/main_layout/main_navigation.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/ai_assistant_screen.dart';
import 'screens/home/notifikasi_screen.dart';
import 'screens/home/private_trip_screen.dart';
import 'screens/history/riwayat_booking_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        // Daftarkan AuthProvider di sini
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        
        // Jika nanti ada provider lain (seperti BookingProvider), tambahkan di bawahnya:
        // ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],

    child: MaterialApp(
        title: 'Marlibu Travel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF98845)),
          useMaterial3: true,
        ),
     
      // Aplikasi dimulai dari SplashScreen
      home: const SplashScreen(),
      routes: {
        // Splash & Auth
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/lupa-password': (context) => const LupaPasswordScreen(),
        '/otp-verification': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final email = args is String ? args : '';
          return OtpVerificationScreen(email: email);
        },
        '/kata-sandi-baru': (context) => const KataSandiBaruScreen(),

        // Main Layout & Home
        '/main': (context) => const MainNavigation(),
        '/home': (context) => const HomeScreen(),
        '/cari-travel': (context) => const CariTravelScreen(),
        '/ai-assistant': (context) => const AiAssistantScreen(),
        '/notifikasi': (context) => const NotifikasiScreen(),
        '/private-trip': (context) => const PrivateTripScreen(),
        '/riwayat-booking': (context) => const RiwayatBookingScreen(),

        // Profile & Submenu
        '/profile': (context) => const ProfileScreen(),
        '/pengaturan': (context) => const PengaturanScreen(),
        '/pusat-bantuan': (context) => const PusatBantuanScreen(),
        '/tentang-kami': (context) => const TentangKamiScreen(),
        '/syarat-ketentuan': (context) => const SyaratKetentuanScreen(),
        '/kebijakan-privasi': (context) => const KebijakanPrivasiScreen(),
        '/ajukan-refund': (context) => const AjukanRefundScreen(),
        '/logout': (context) => const LogoutScreen(),
      },
    ),
    );
  }
}