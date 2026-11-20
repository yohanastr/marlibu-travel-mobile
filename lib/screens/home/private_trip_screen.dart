import 'package:flutter/material.dart';
import 'pilih_unit_screen.dart';

typedef PaketWisataItem = Map<String, dynamic>;

class PrivateTripScreen extends StatefulWidget {
  const PrivateTripScreen({super.key});

  @override
  State<PrivateTripScreen> createState() => _PrivateTripScreenState();
}

class _PrivateTripScreenState extends State<PrivateTripScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<PaketWisataItem> _paketWisata = [
    {
      'judul': 'YOGYAKARTA',
      'namaKota': 'Yogyakarta',
      'harga': 'Rp. 1.200.000',
      'satuan': '/org',
      'imageUrl':
          'https://images.unsplash.com/photo-1584810359583-96fc3448beaa?auto=format&fit=crop&w=800&q=80',
      'destinasi': ['Borobudur', 'Malioboro', 'Prambanan', 'Kraton'],
      'fasilitas': ['Transport', 'Hotel', 'Makan 2 kali', 'Guide'],
    },
    {
      'judul': 'BALI',
      'namaKota': 'Bali',
      'harga': 'Rp. 2.800.000',
      'satuan': '/org',
      'imageUrl':
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=800&q=80',
      'destinasi': ['Pantai Kuta', 'Uluwatu', 'Tanah Lot', 'Bedugul'],
      'fasilitas': ['Transport', 'Hotel', 'Makan 2 kali', 'Guide'],
    },
    {
      'judul': 'BROMO',
      'namaKota': 'Bromo',
      'harga': 'Rp. 450.000',
      'satuan': '/org',
      'imageUrl':
          'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272?auto=format&fit=crop&w=800&q=80',
      'destinasi': ['Penanjakan 1', 'Kawah Bromo', 'Pasir Berbisik', 'Savana'],
      'fasilitas': ['Transport', 'Jeep 4x4', 'Makan 1 kali', 'Guide'],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<PaketWisataItem> filteredPaket = _paketWisata.where((item) {
      final judul = item['judul'].toString().toLowerCase();
      return judul.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFD6E6F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header "< Privat Trip"
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 20, 8),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: Color(0xFF0F172A),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Privat Trip',
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
              ),
            ),

            // Search Bar Putih Membulat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF94A3B8)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  decoration: const InputDecoration(
                    hintText: 'Search destination...',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: Color(0xFF475569),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Daftar Kartu Destinasi (YOGYAKARTA, BALI, BROMO)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredPaket.length,
                itemBuilder: (context, index) {
                  final paket = filteredPaket[index];
                  return _buildDestinasiCard(context, paket);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinasiCard(
    BuildContext context,
    PaketWisataItem paket,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          paket['judul'],
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0066B2),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPrivateTripScreen(paket: paket),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Wisata
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: Image.network(
                    paket['imageUrl'],
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 110,
                      color: const Color(0xFFCBD5E1),
                      child: const Center(
                        child: Icon(
                          Icons.landscape,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // Bagian Bawah Kartu (Harga & Tombol Detail ->)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: paket['harga'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            TextSpan(
                              text: paket['satuan'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 9,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0066B2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Detail',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 11,
                              color: Colors.white,
                            ),
                          ],
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
    );
  }
}

// ============================================================================
// LAYAR 2: DETAIL PRIVATE TRIP (Destinasi Wisata Bisa Diklik / Dipilih)
// ============================================================================
class DetailPrivateTripScreen extends StatefulWidget {
  final PaketWisataItem paket;

  const DetailPrivateTripScreen({super.key, required this.paket});

  @override
  State<DetailPrivateTripScreen> createState() =>
      _DetailPrivateTripScreenState();
}

class _DetailPrivateTripScreenState extends State<DetailPrivateTripScreen> {
  final Set<String> _destinasiDipilih = {};

  @override
  Widget build(BuildContext context) {
    final List<String> destinasiList =
        List<String>.from(widget.paket['destinasi']);
    final List<String> fasilitasList =
        List<String>.from(widget.paket['fasilitas']);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Hero Header + Nama Kota + Tombol Back
            Stack(
              children: [
                Image.network(
                  widget.paket['imageUrl'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: const Color(0xFF0066B2),
                  ),
                ),
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 36,
                  left: 14,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.85),
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: Color(0xFF0F172A),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  left: 20,
                  child: Text(
                    widget.paket['namaKota'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card 1: Destinasi wisata (Grid 2x2 Bisa Diklik)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Destinasi wisata',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            if (_destinasiDipilih.isNotEmpty)
                              Text(
                                '${_destinasiDipilih.length} dipilih',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF7A00),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: destinasiList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 12,
                            childAspectRatio: 3.1,
                          ),
                          itemBuilder: (context, index) {
                            final namaTempat = destinasiList[index];
                            final isSelected =
                                _destinasiDipilih.contains(namaTempat);

                            return Material(
                              color: isSelected
                                  ? const Color(0xFFFF7A00)
                                  : const Color(0xFF0066B2),
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _destinasiDipilih.remove(namaTempat);
                                    } else {
                                      _destinasiDipilih.add(namaTempat);
                                    }
                                  });
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (isSelected) ...[
                                        const Icon(
                                          Icons.check_circle,
                                          size: 13,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 4),
                                      ],
                                      Text(
                                        namaTempat,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card 2: SUDAH TERMASUK (Checklist Fasilitas)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SUDAH TERMASUK',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const Divider(height: 18, color: Color(0xFFE2E8F0)),
                        ...fasilitasList.map((fasilitas) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_rounded,
                                  size: 16,
                                  color: Color(0xFF0F172A),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  fasilitas,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Harga Rata Kanan + Garis Bawah Tipis
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF0066B2),
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.paket['harga'],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0066B2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Harga per orang',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Tombol Oranye "Pilih Unit Kendaraan ->" mengirim data paket ke PilihUnitScreen
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        final int hargaAngka = int.tryParse(
                              widget.paket['harga']
                                  .toString()
                                  .replaceAll(RegExp(r'[^0-9]'), ''),
                            ) ??
                            1200000;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PilihUnitScreen(
                              namaKota: widget.paket['namaKota'],
                              hargaPaketText: widget.paket['harga'],
                              hargaPaketAngka: hargaAngka,
                              destinasiDipilih: _destinasiDipilih.toList(),
                            ),
                          ),
                        );
                      },
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
                            'Pilih Unit Kendaraan',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}