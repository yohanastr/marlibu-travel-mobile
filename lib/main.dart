import 'package:flutter/material.dart';

// Halaman temanmu
import 'screens/booking/cari_travel_screen.dart';

// Halaman bagian Novi
import 'screens/main_layout/main_navigation.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/ai_assistant_screen.dart';
import 'screens/home/notifikasi_screen.dart';
import 'screens/home/private_trip_screen.dart';
import 'screens/history/riwayat_booking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marlibu Travel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF98845)),
        useMaterial3: true,
        // fontFamily: 'Poppins', // Aktifkan jika sudah mendaftarkan font Poppins di pubspec.yaml
      ),
      // MainNavigation sebagai layar utama yang memuat bottom bar (Riwayat, Home, Profile)
      home: const MainNavigation(),
      // Daftar rute agar navigasi antar halaman kamu dan temanmu terhubung
      routes: {
        '/main': (context) => const MainNavigation(),
        '/home': (context) => const HomeScreen(),
        '/cari-travel': (context) => const CariTravelScreen(),
        '/ai-assistant': (context) => const AiAssistantScreen(),
        '/notifikasi': (context) => const NotifikasiScreen(),
        '/private-trip': (context) => const PrivateTripScreen(),
        '/riwayat-booking': (context) => const RiwayatBookingScreen(),
      },
    );
  }
}