import 'package:flutter/material.dart';
import 'private_trip_screen.dart';
import '../booking/cari_travel_screen.dart';
import '../history/riwayat_booking_screen.dart';

typedef NotifikasiItem = Map<String, String>;

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key});

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  String _selectedKategori = 'Semua';

  final List<String> _kategoriTabs = [
    'Semua',
    'Promo',
    'Informasi',
    'Sistem',
  ];

  final List<NotifikasiItem> _daftarNotifikasi = [
    {
      'kategori': 'Promo',
      'judul': 'Promo Akhir Pekan! Diskon 20%',
      'pesan':
          'Gunakan kode promo WEEKEND20 untuk semua rute perjalanan reguler Jawa-Bali minggu ini!',
      'aksi': 'Pesan Tiket',
    },
    {
      'kategori': 'Informasi',
      'judul': 'Jadwal Keberangkatan Esok Hari',
      'pesan':
          'Yogyakarta dijadwalkan besok pukul 09:00 WIB. Pastikan hadir 15 menit sebelum keberangkatan.',
      'aksi': 'Lihat detail',
    },
    {
      'kategori': 'Sistem',
      'judul': 'Keamanan Akun Ditingkatkan',
      'pesan':
          'Kami telah memperbarui sistem keamanan aplikasi. Kamu kini bisa mengaktifkan login biometrik di Pengaturan.',
      'aksi': 'Pengaturan',
    },
    {
      'kategori': 'Promo',
      'judul': 'Paket Private Trip Nusa Penida Spesial',
      'pesan':
          'Dapatkan cashback hingga Rp 200.000 untuk pemesanan paket liburan kustom Nusa Penida.',
      'aksi': 'Beli tiket',
    },
  ];

  void _handleAksiNotifikasi(BuildContext context, String aksi) {
    switch (aksi) {
      case 'Pesan Tiket':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CariTravelScreen(),
          ),
        );
        break;
      case 'Lihat detail':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RiwayatBookingScreen(),
          ),
        );
        break;
      case 'Beli tiket':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PrivateTripScreen(),
          ),
        );
        break;
      case 'Pengaturan':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Menuju halaman Pengaturan Akun'),
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<NotifikasiItem> filteredList = _selectedKategori == 'Semua'
        ? _daftarNotifikasi
        : _daftarNotifikasi
            .where((item) => item['kategori'] == _selectedKategori)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER "< Notifikasi" + Subjudul
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 20, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF0F172A),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifikasi',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Jangan lewatkan info tentang liburanmu',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. FILTER TAB PILL DENGAN SHADOW (Semua, Promo, Informasi, Sistem)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _kategoriTabs.map((tab) {
                  final bool isSelected = _selectedKategori == tab;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: tab == _kategoriTabs.last ? 0 : 8,
                      ),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedKategori = tab),
                        child: Container(
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF0066B2)
                                : const Color(0xFFEBF3FA),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? const Color(0x400066B2)
                                    : const Color(0x1A000000),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            tab,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF0066B2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 18),

            // 3. DAFTAR KARTU NOTIFIKASI
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final item = filteredList[index];
                  return _buildNotifikasiCard(context, item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifikasiCard(BuildContext context, NotifikasiItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FA),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['judul']!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF005299),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item['pesan']!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.5,
              height: 1.4,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => _handleAksiNotifikasi(context, item['aksi']!),
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['aksi']!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0066B2),
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 14,
                      color: Color(0xFF0066B2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}