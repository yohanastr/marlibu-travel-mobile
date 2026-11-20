import 'package:flutter/material.dart';
// Pastikan path import ini sesuai dengan letak folder kamu
import 'screens/booking/cari_travel_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marlibu Travel', // Judul aplikasinya sudah diubah di sini
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF98845)),
        useMaterial3: true,
        // fontFamily: 'Poppins', // Aktifkan kalau kamu pakai font Poppins
      ),
      home: const CariTravelScreen(), 
    );
  }
}