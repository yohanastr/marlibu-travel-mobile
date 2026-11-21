import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notifikasi_screen.dart';
import 'private_trip_screen.dart';
import 'ai_assistant_screen.dart';
import '../booking/cari_travel_screen.dart';
import '../history/riwayat_booking_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/pengaturan_screen.dart';
import '../profile/pusat_bantuan_screen.dart';
import '../profile/tentang_kami_screen.dart';
import '../profile/ajukan_refund_screen.dart';
import '../profile/logout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _kotaAsal;
  String? _kotaTujuan;
  DateTime? _tanggalBerangkat;

  final List<String> _daftarKota = [
    'Jakarta',
    'Yogyakarta',
    'Malang',
    'Surabaya',
    'Bali',
  ];

  Future<void> _pilihTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalBerangkat ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() => _tanggalBerangkat = picked);
    }
  }

  String _formatTanggal(DateTime date) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    final hari = date.day.toString().padLeft(2, '0');
    return '$hari ${bulan[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: _buildSubmenuDrawer(),
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER ATAS (Logo Marlibu dari Assets di Kiri + Lonceng & Menu di Kanan)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/marlibu_logo.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotifikasiScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.black87,
                          size: 26,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            _scaffoldKey.currentState?.openEndDrawer(),
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.black87,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. CARD TUJUAN KEBERANGKATAN
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade400, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tujuan Keberangkatan',
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0077CC),
                          ),
                        ),
                        if (_kotaAsal != null ||
                            _kotaTujuan != null ||
                            _tanggalBerangkat != null)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _kotaAsal = null;
                                _kotaTujuan = null;
                                _tanggalBerangkat = null;
                              });
                            },
                            child: Text(
                              'Reset',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFF852D),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Label & Dropdown Keberangkatan
                    Text(
                      'Keberangkatan',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildDropdownKota(
                      hint: 'Pilih kota keberangkatan',
                      value: _kotaAsal,
                      onChanged: (val) => setState(() => _kotaAsal = val),
                    ),
                    const SizedBox(height: 10),

                    // Label & Dropdown Kedatangan
                    Text(
                      'Kedatangan',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildDropdownKota(
                      hint: 'Pilih Kota Tujuan',
                      value: _kotaTujuan,
                      onChanged: (val) => setState(() => _kotaTujuan = val),
                    ),
                    const SizedBox(height: 10),

                    // Label & Picker Tanggal Keberangkatan
                    Text(
                      'Tanggal Keberangkatan',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: _pilihTanggal,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3FC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              size: 16,
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _tanggalBerangkat == null
                                  ? 'Pilih tanggal'
                                  : _formatTanggal(_tanggalBerangkat!),
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: _tanggalBerangkat == null
                                    ? Colors.grey.shade600
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tombol Oranye "Cari Keberangkatan"
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 38,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CariTravelScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF852D),
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor:
                                const Color(0xFFFF852D).withOpacity(0.35),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cari Keberangkatan',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 3. BANNER PROMO (Promo Weekend! & Promo Tahun Baru!)
              _buildPromoCard(
                title: 'Promo Weekend!',
                subtitle: 'Diskon 20% semua rute · Kode: WEEKEND20',
              ),
              const SizedBox(height: 12),
              _buildPromoCard(
                title: 'Promo Tahun Baru!',
                subtitle: 'Diskon 50% semua rute · Kode: NEWYEAR',
              ),
              const SizedBox(height: 18),

              // 4. SECTION LAYANAN (Private Trip & AI Assistant)
              Text(
                'Layanan',
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildLayananCard(
                      icon: Icons.directions_car_filled_rounded,
                      title: 'Private Trip',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivateTripScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildLayananCard(
                      icon: Icons.smart_toy_rounded,
                      title: 'AI Assistant',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AiAssistantScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION BAR (Riwayat Booking, Home, Profile)
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tab 1: Riwayat Booking
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RiwayatBookingScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.assignment_outlined,
                          color: Color(0xFF0077CC),
                          size: 22,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Riwayat Booking',
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Tab 2: Home (Aktif - Kotak Biru)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0077CC),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0077CC).withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tab 3: Profile
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfileScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          color: Color(0xFF0077CC),
                          size: 22,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownKota({
    required String hint,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          hint: Text(
            hint,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: Colors.grey.shade600,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: Colors.grey.shade700,
          ),
          items: _daftarKota.map((kota) {
            return DropdownMenuItem<String>(
              value: kota,
              child: Text(
                kota,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildPromoCard({required String title, required String subtitle}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF0077CC).withOpacity(0.20),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0077CC),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayananCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade400, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFFF852D), size: 36),
            const SizedBox(height: 6),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0077CC),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SUBMENU DRAWER BIRU KANAN ATAS (Terhubung ke Halaman Profile & LogoutScreen)
  Widget _buildSubmenuDrawer() {
    final List<String> menuItems = [
      'Pengaturan',
      'Pusat Bantuan',
      'Tentang Kami',
      'Ajukan Refund',
      'Logout',
    ];

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 195,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xFF0077CC),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            bottomLeft: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(-2, 4),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: menuItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      switch (item) {
                        case 'Pengaturan':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PengaturanScreen(),
                            ),
                          );
                          break;
                        case 'Pusat Bantuan':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PusatBantuanScreen(),
                            ),
                          );
                          break;
                        case 'Tentang Kami':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TentangKamiScreen(),
                            ),
                          );
                          break;
                        case 'Ajukan Refund':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AjukanRefundScreen(),
                            ),
                          );
                          break;
                        case 'Logout':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LogoutScreen(),
                            ),
                          );
                          break;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0077CC),
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}