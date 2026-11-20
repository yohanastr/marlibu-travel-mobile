import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'detail_riwayat_screen.dart';

typedef RiwayatBookingItem = Map<String, String>;

class RiwayatBookingScreen extends StatefulWidget {
  const RiwayatBookingScreen({super.key});

  @override
  State<RiwayatBookingScreen> createState() => _RiwayatBookingScreenState();
}

class _RiwayatBookingScreenState extends State<RiwayatBookingScreen> {
  String _selectedFilter = 'Semua';

  final List<String> _filterTabs = [
    'Semua',
    'Aktif /\nMendatang',
    'Selesai',
    'Dibatalkan',
  ];

  final List<RiwayatBookingItem> _daftarRiwayat = [
    {
      'layanan': 'Reguler Travel',
      'status': 'Mendatang',
      'asal': 'Jakarta',
      'jamBerangkat': '06:00',
      'tujuan': 'Yogyakarta',
      'jamTiba': '14:00',
      'tanggal': '12 Sep 2026',
      'kode': 'JNT-K8K9L2',
      'harga': 'Rp. 375.000',
      'penumpang': '2 Penumpang (Kursi 3, 4)',
      'armada': 'Toyota Hiace Commuter',
      'metodeBayar': 'Transfer Bank BCA',
    },
    {
      'layanan': 'Private Trip',
      'status': 'Selesai',
      'asal': 'Surabaya',
      'jamBerangkat': '08:00',
      'tujuan': 'Bali',
      'jamTiba': '20:00',
      'tanggal': '2 Sep 2026',
      'kode': 'JNT-B3M1P8',
      'harga': 'Rp. 3.200.000',
      'penumpang': '4 Penumpang (1 Unit Mobil)',
      'armada': 'Toyota Innova Reborn',
      'metodeBayar': 'DANA E-Wallet',
    },
    {
      'layanan': 'Reguler Travel',
      'status': 'Selesai',
      'asal': 'Jakarta',
      'jamBerangkat': '08:00',
      'tujuan': 'Bandung',
      'jamTiba': '12:00',
      'tanggal': '15 Agu 2026',
      'kode': 'JNT-C9A2V4',
      'harga': 'Rp. 180.000',
      'penumpang': '1 Penumpang (Kursi 2)',
      'armada': 'Toyota Hiace Premio',
      'metodeBayar': 'Transfer Bank Mandiri',
    },
    {
      'layanan': 'Reguler Travel',
      'status': 'Dibatalkan',
      'asal': 'Jakarta',
      'jamBerangkat': '07:30',
      'tujuan': 'Semarang',
      'jamTiba': '13:30',
      'tanggal': '20 Jul 2026',
      'kode': 'JNT-R5F7D1',
      'harga': 'Rp. 190.000',
      'penumpang': '1 Penumpang (Kursi 5)',
      'armada': 'Toyota Hiace Commuter',
      'metodeBayar': 'DANA E-Wallet',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<RiwayatBookingItem> filteredList = _daftarRiwayat.where((item) {
      if (_selectedFilter == 'Semua') return true;
      if (_selectedFilter.contains('Mendatang')) {
        return item['status'] == 'Mendatang';
      }
      return item['status'] == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER "< Riwayat Pesanan"
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 20, 14),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      LucideIcons.chevronLeft,
                      size: 22,
                      color: Color(0xFF0F172A),
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Riwayat Pesanan',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),

            // 2. FILTER TAB PILL (Semua, Aktif/Mendatang, Selesai, Dibatalkan)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: _filterTabs.map((tab) {
                  final bool isSelected = _selectedFilter == tab;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: tab == _filterTabs.last ? 0 : 8,
                      ),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFilter = tab),
                        child: Container(
                          height: 34,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF0066B2)
                                : const Color(0xFFEBF3FA),
                            borderRadius: BorderRadius.circular(18),
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
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 9,
                              height: 1.15,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 3. DAFTAR KARTU RIWAYAT PESANAN
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final item = filteredList[index];
                  return _buildRiwayatCard(context, item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiwayatCard(BuildContext context, RiwayatBookingItem item) {
    final String status = item['status']!;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFCBD5E1)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Baris 1: Jenis Layanan & Badge Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['layanan']!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0066B2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Baris 2: Rute Asal --- [Ikon Mobil] --- Rute Tujuan
          Row(
            children: [
              // Kiri: Kota Asal & Jam Berangkat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['asal']!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    item['jamBerangkat']!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),

              // Tengah: Titik Biru - Garis - Mobil - Garis - Titik Oranye
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0066B2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.5,
                          color: const Color(0xFFCBD5E1),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          LucideIcons.car,
                          size: 18,
                          color: Color(0xFF0066B2),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.5,
                          color: const Color(0xFFCBD5E1),
                        ),
                      ),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF7A00),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Kanan: Kota Tujuan & Jam Tiba
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item['tujuan']!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    item['jamTiba']!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 18, color: Color(0xFFE2E8F0)),

          // Baris 3: Tanggal & Kode Booking (Kiri) + Harga & Lihat Tiket > (Kanan)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0xFF64748B),
                      ),
                      children: [
                        const TextSpan(text: 'Tanggal: '),
                        TextSpan(
                          text: item['tanggal']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0xFF64748B),
                      ),
                      children: [
                        const TextSpan(text: 'Kode: '),
                        TextSpan(
                          text: item['kode']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item['harga']!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailRiwayatScreen(booking: item),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lihat Tiket',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0066B2),
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          LucideIcons.chevronRight,
                          size: 13,
                          color: Color(0xFF0066B2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}