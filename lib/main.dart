import 'package:flutter/material.dart';

void main() {
  runApp(const MarlibuTravelApp());
}

class MarlibuTravelApp extends StatelessWidget {
  const MarlibuTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marlibu Travel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066CC)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// 1. Model & Data Dummy Paket Travel
class PaketTravel {
  final String id;
  final String nama;
  final String destinasi;
  final String durasi;
  final int harga;
  final String deskripsi;
  final IconData ikon;

  const PaketTravel({
    required this.id,
    required this.nama,
    required this.destinasi,
    required this.durasi,
    required this.harga,
    required this.deskripsi,
    required this.ikon,
  });
}

const List<PaketTravel> daftarPaketDummy = [
  PaketTravel(
    id: 'PKT-01',
    nama: 'Bromo Sunrise Midnight Trip',
    destinasi: 'Malang - Gunung Bromo',
    durasi: '1 Hari 1 Malam',
    harga: 350000,
    deskripsi:
        'Penjemputan area Malang kota, Jeep 4x4 ke Penanjakan Sunrise, Kawah Bromo, Pasir Berbisik, dan Bukit Teletubbies.',
    ikon: Icons.landscape,
  ),
  PaketTravel(
    id: 'PKT-02',
    nama: 'Pantai Selatan & Balekambang',
    destinasi: 'Malang Selatan',
    durasi: '1 Hari Full Day',
    harga: 250000,
    deskripsi:
        'Wisata seharian ke Pantai Balekambang, Pantai Goa Cina, dan Pantai Tiga Warna termasuk transportasi AC dan tiket masuk.',
    ikon: Icons.beach_access,
  ),
  PaketTravel(
    id: 'PKT-03',
    nama: 'City Tour Batu & Jatim Park',
    destinasi: 'Kota Wisata Batu',
    durasi: '2 Hari 1 Malam',
    harga: 750000,
    deskripsi:
        'Kunjungan ke Jatim Park 2, Museum Angkut, Alun-Alun Batu, serta pusat oleh-oleh khas Batu dengan penginapan nyaman.',
    ikon: Icons.location_city,
  ),
];

// 2. Halaman Beranda (Daftar Paket & Pencarian)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String kataKunci = '';

  String formatRupiah(int angka) {
    final str = angka.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp $buffer';
  }

  @override
  Widget build(BuildContext context) {
    final hasilFilter = daftarPaketDummy.where((paket) {
      return paket.nama.toLowerCase().contains(kataKunci.toLowerCase()) ||
          paket.destinasi.toLowerCase().contains(kataKunci.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Marlibu Travel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0066CC),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Kolom Pencarian
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => kataKunci = value),
              decoration: InputDecoration(
                hintText: 'Cari destinasi atau nama paket...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Daftar Paket Travel
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: hasilFilter.length,
              itemBuilder: (context, index) {
                final paket = hasilFilter[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailBookingScreen(paket: paket),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0066CC).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              paket.ikon,
                              color: const Color(0xFF0066CC),
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  paket.nama,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${paket.destinasi} • ${paket.durasi}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${formatRupiah(paket.harga)} / orang',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0066CC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Halaman Detail Paket & Form Pemesanan
class DetailBookingScreen extends StatefulWidget {
  final PaketTravel paket;
  const DetailBookingScreen({super.key, required this.paket});

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  final _namaController = TextEditingController();
  final _tanggalController = TextEditingController();
  int jumlahOrang = 1;

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  void konfirmasiPesanan() {
    if (_namaController.text.isEmpty || _tanggalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi nama pemesan dan tanggal berangkat')),
      );
      return;
    }

    final totalHarga = widget.paket.harga * jumlahOrang;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pesanan Berhasil Dibuat'),
        content: Text(
          'Paket: ${widget.paket.nama}\n'
          'Pemesan: ${_namaController.text}\n'
          'Tanggal: ${_tanggalController.text}\n'
          'Peserta: $jumlahOrang orang\n'
          'Total: Rp $totalHarga',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail & Pemesanan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.paket.nama,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              '${widget.paket.destinasi} (${widget.paket.durasi})',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Text(widget.paket.deskripsi, style: const TextStyle(fontSize: 15)),
            const Divider(height: 32),
            const Text(
              'Form Pemesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap Pemesan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tanggalController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Berangkat (misal: 20 Nov 2026)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah Peserta:', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      onPressed: jumlahOrang > 1
                          ? () => setState(() => jumlahOrang--)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$jumlahOrang', style: const TextStyle(fontSize: 16)),
                    IconButton(
                      onPressed: () => setState(() => jumlahOrang++),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066CC),
                  foregroundColor: Colors.white,
                ),
                onPressed: konfirmasiPesanan,
                child: const Text('Pesan Sekarang', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}