import 'package:flutter/material.dart';
import 'titik_jemput_private_trip_screen.dart';

typedef UnitKendaraan = Map<String, dynamic>;

class PilihUnitScreen extends StatefulWidget {
  final String namaKota;
  final String hargaPaketText;
  final int hargaPaketAngka;
  final List<String> destinasiDipilih;

  const PilihUnitScreen({
    super.key,
    this.namaKota = 'Yogyakarta',
    this.hargaPaketText = 'Rp. 1.200.000',
    this.hargaPaketAngka = 1200000,
    this.destinasiDipilih = const ['Borobudur', 'Malioboro'],
  });

  @override
  State<PilihUnitScreen> createState() => _PilihUnitScreenState();
}

class _PilihUnitScreenState extends State<PilihUnitScreen> {
  int? _selectedIndex;

  final List<UnitKendaraan> _daftarUnit = [
    {
      'nama': 'Toyota Hiace',
      'plat': 'B 1234 XYZ',
      'tipe': 'Van Premium',
      'detail': 'B 1234 XYZ · Van Premium',
      'fasilitas': 'AC · WiFi · Charger · Snack',
      'kursi': '12 Kursi',
      'harga': 'Rp 50.000',
      'hargaAngka': 50000,
      'imageUrl':
          'https://imgd.aeplcdn.com/664x374/n/cw/ec/47336/hiace-exterior-right-front-three-quarter.jpeg?q=80',
    },
    {
      'nama': 'Innova Reborn',
      'plat': 'B 5678 ABC',
      'tipe': 'Medium MPV',
      'detail': 'B 5678 ABC · Medium MPV',
      'fasilitas': 'AC · Charger · Snack',
      'kursi': '7 Kursi',
      'harga': 'Rp 80.000',
      'hargaAngka': 80000,
      'imageUrl':
          'https://imgd.aeplcdn.com/664x374/n/cw/ec/140809/innova-crysta-exterior-right-front-three-quarter-2.png?isig=0&q=80',
    },
    {
      'nama': 'Avanza Veloz',
      'plat': 'B 9101 DEF',
      'tipe': 'Low MPV',
      'detail': 'B 9101 DEF · Low MPV',
      'fasilitas': 'AC · Charger',
      'kursi': '7 Kursi',
      'harga': 'Rp 65.000',
      'hargaAngka': 65000,
      'imageUrl':
          'https://imgd.aeplcdn.com/664x374/n/cw/ec/115025/veloz-exterior-right-front-three-quarter.jpeg?q=80',
    },
  ];

  void _lanjutKeDetailPenjemputan() {
    if (_selectedIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih unit kendaraan terlebih dahulu'),
        ),
      );
      return;
    }

    final unitTerpilih = _daftarUnit[_selectedIndex!];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TitikJemputPrivateTripScreen(
          namaKota: widget.namaKota,
          hargaPaketAngka: widget.hargaPaketAngka,
          destinasiDipilih: widget.destinasiDipilih,
          unit: unitTerpilih,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER "< Pilih Kendaraan"
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 20, 12),
              child: Row(
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
                  const Text(
                    'Pilih Kendaraan',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),

            // 2. DAFTAR KARTU UNIT KENDARAAN
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
                child: Column(
                  children: [
                    _buildUnitCard(0),
                    const SizedBox(height: 16),
                    _buildUnitCard(1),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: _lanjutKeDetailPenjemputan,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildUnitCard(2),
                  ],
                ),
              ),
            ),

            // 3. BUTTON BAWAH: LANJUT KE DETAIL PENJEMPUTAN
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: _lanjutKeDetailPenjemputan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                    foregroundColor: const Color(0xFF0F172A),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lanjut ke Detail Penjemputan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitCard(int index) {
    final unit = _daftarUnit[index];
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF3FA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0066B2)
                : const Color(0xFFD6E4F0),
            width: isSelected ? 1.8 : 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 92,
              child: Center(
                child: Image.network(
                  unit['imageUrl'],
                  height: 86,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.directions_car_filled_rounded,
                      size: 64,
                      color: Color(0xFF0066B2),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit['nama'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        unit['detail'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 9.5,
                          color: Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        unit['fasilitas'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 9,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      unit['kursi'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.5,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      unit['harga'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}