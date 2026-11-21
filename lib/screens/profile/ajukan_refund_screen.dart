import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AjukanRefundScreen extends StatefulWidget {
  const AjukanRefundScreen({super.key});

  @override
  State<AjukanRefundScreen> createState() => _AjukanRefundScreenState();
}

class _AjukanRefundScreenState extends State<AjukanRefundScreen> {
  final _kodeBookingController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _penjelasanController = TextEditingController();

  String? _selectedAlasan;
  String? _selectedMetode;

  final List<String> _daftarAlasan = [
    'Perubahan Jadwal Perjalanan',
    'Salah Memilih Rute / Tanggal',
    'Keperluan Mendadak',
    'Kendala Pembayaran Ganda',
    'Lainnya',
  ];

  final List<String> _daftarMetode = [
    'Transfer Bank (BCA / BRI / BNI / Mandiri)',
    'GoPay',
    'OVO',
    'DANA',
    'ShopeePay',
  ];

  @override
  void dispose() {
    _kodeBookingController.dispose();
    _nomorTeleponController.dispose();
    _penjelasanController.dispose();
    super.dispose();
  }

  void _submitRefund() {
    if (_kodeBookingController.text.trim().isEmpty ||
        _nomorTeleponController.text.trim().isEmpty ||
        _selectedAlasan == null ||
        _selectedMetode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Harap lengkapi semua data pengajuan refund terlebih dahulu.',
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFF0077CC).withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF0077CC),
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Pengajuan Terkirim',
                style: GoogleFonts.poppins(
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Permintaan pengembalian dana untuk kode booking ${_kodeBookingController.text.trim()} sedang diproses dalam waktu maksimal 24 jam.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  height: 1.45,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF852D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Selesai',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Header Tetap
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 68,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    LucideIcons.chevronLeft,
                    color: Colors.black,
                    size: 26,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Ajukan Pengembalian Dana',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 2. Konten Form Scrollable
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          // Box Informasi Pengembalian Dana (Border Merah Lembut)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.red.shade300,
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: Icon(
                    LucideIcons.info,
                    color: Color(0xFF0077CC),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Pengembalian Dana (Refund)',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pengembalian dana untuk pembatalan tiket adalah 75% dari harga tiket (potongan biaya administrasi 25%). Proses pengembalian dana memerlukan waktu 24 jam.',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          height: 1.45,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Row Input: Kode Booking & Nomor Telepon
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kode Booking',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _kodeBookingController,
                      style: GoogleFonts.poppins(fontSize: 12),
                      decoration: _inputDecoration('Contoh: MLB-1024'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nomor Telepon',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _nomorTeleponController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.poppins(fontSize: 12),
                      decoration: _inputDecoration('08xxxxxxxxxx'),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Card 1: Detail Masalah
          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Masalah',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pilih Alasan',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildDropdownField(
                  hint: 'Alasan Pengembalian',
                  value: _selectedAlasan,
                  items: _daftarAlasan,
                  onChanged: (val) => setState(() => _selectedAlasan = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Card 2: Informasi Tambahan
          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Tambahan',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Penjelasan Masalah',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _penjelasanController,
                  maxLines: 3,
                  style: GoogleFonts.poppins(fontSize: 12),
                  decoration: _inputDecoration(
                    'Tuliskan detail masalah Anda di sini...',
                    verticalPadding: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Card 3: Metode Pengembalian Dana
          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Metode Pengembalian Dana',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                _buildDropdownField(
                  hint: 'Pilih Metode...',
                  value: _selectedMetode,
                  items: _daftarMetode,
                  onChanged: (val) => setState(() => _selectedMetode = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Tombol Submit Oranye Full Width
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _submitRefund,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF852D),
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: const Color(0xFFFF852D).withOpacity(0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Lanjut isi form',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: child,
      );

  InputDecoration _inputDecoration(
    String hint, {
    double verticalPadding = 11,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 11.5,
        color: Colors.grey.shade500,
      ),
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: verticalPadding,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF0077CC), width: 1.3),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
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
          icon: const Icon(
            LucideIcons.chevronDown,
            size: 18,
            color: Colors.black87,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
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
}