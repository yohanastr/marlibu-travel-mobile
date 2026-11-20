import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

typedef ChatBubbleItem = Map<String, dynamic>;

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _inputController = TextEditingController();

  String? _selectedPertanyaan;
  String? _selectedBudget;
  final List<ChatBubbleItem> _chatHistory = [];

  final List<String> _rekomendasiPertanyaan = [
    'Rekomendasi wisata di Yogyakarta',
    'Kuliner khas Malang',
    'Susun jadwal selama liburan',
  ];

  final List<String> _pilihanBudget = [
    '1 Jt - 1.5 Jt',
    '1.5 Jt - 2.5 Jt',
    '2.5 Jt - 4 Jt',
  ];

  void _kirimPertanyaan({String? customText}) {
    String pesanUser = '';

    if (customText != null && customText.trim().isNotEmpty) {
      pesanUser = customText.trim();
    } else if (_selectedPertanyaan != null) {
      final budgetLabel = _selectedBudget ?? '1 Jt - 1.5 Jt';
      pesanUser = '$_selectedPertanyaan\nBudget $budgetLabel';
    } else if (_selectedBudget != null) {
      pesanUser =
          'Rekomendasi wisata di Yogyakarta\nBudget $_selectedBudget';
    }

    if (pesanUser.isEmpty) return;

    final hasil = _buatJawabanSimulasi(pesanUser);

    setState(() {
      _chatHistory.add({
        'isUser': true,
        'isWarning': false,
        'text': pesanUser,
      });
      _chatHistory.add({
        'isUser': false,
        'isWarning': hasil['isWarning'],
        'text': hasil['text'],
      });
      _inputController.clear();
    });
  }

  Map<String, dynamic> _buatJawabanSimulasi(String query) {
    final q = query.toLowerCase();

    if (q.contains('yogyakarta') || q.contains('jogja')) {
      return {
        'isWarning': false,
        'text': 'Rekomendasi Destinasi Wisata\n'
            'Terpopuler & Hemat:\n'
            'Jalan Malioboro\n'
            '4.8 stars rating 4.8\n'
            'Jalan Malioboro merupakan pusat ikonik kota Yogyakarta yang menjadi tempat favorit para wisatawan untuk menikmati suasana kota dan berburu jajanan khas.\n'
            '• Harga tiket: Gratis (hanya bayar parkir jika membawa kendaraan).\n'
            '• Fasilitas & Daya Tarik: Area pejalan kaki yang luas, musisi jalanan, kuliner angkringan, serta dekat dengan Pasar Beringharjo untuk membeli oleh-oleh.',
      };
    } else if (q.contains('malang')) {
      return {
        'isWarning': false,
        'text': 'Rekomendasi Kuliner Khas Malang:\n'
            'Bakso President & Pos Ketan Legenda 1967\n'
            '4.9 stars rating 4.9\n'
            '• Bakso President: Terkenal dengan bakso bakar dan pemandangan unik di pinggir rel kereta api.\n'
            '• Pos Ketan Legenda (Alun-Alun Batu): Menyajikan ketan hangat dengan berbagai topping keju, susu, dan durian.\n'
            '• Estimasi biaya: Rp 15.000 - Rp 35.000 per porsi.',
      };
    } else if (q.contains('jadwal') || q.contains('itinerary')) {
      return {
        'isWarning': false,
        'text': 'Rekomendasi Itinerary Liburan:\n'
            '• Hari 1 (07.00): Penjemputan armada Marlibu Travel menuju destinasi utama & wisata kuliner siang.\n'
            '• Hari 1 (15.00): Check-in penginapan & jalan santai sore di pusat kota.\n'
            '• Hari 2 (08.00): Kunjungan pusat oleh-oleh khas daerah sebelum perjalanan pulang.',
      };
    }

    // Pesan panduan sopan jika pertanyaan tidak terdapat di daftar rekomendasi
    return {
      'isWarning': true,
      'text':
          'Pertanyaan ini tidak terdapat di bagian rekomendasi AI Travel.\n'
              'Silakan pilih atau ketik pertanyaan seputar:\n'
              '• Rekomendasi wisata di Yogyakarta\n'
              '• Kuliner khas Malang\n'
              '• Susun jadwal selama liburan',
    };
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool sudahMulaiChat = _chatHistory.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // 1. HEADER ATAS (Tombol "<" + Logo Marlibu + Ikon Robot + AI Travel)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 20, 6),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          if (sudahMulaiChat) {
                            setState(() {
                              _chatHistory.clear();
                              _selectedPertanyaan = null;
                              _selectedBudget = null;
                            });
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 44,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0066B2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Marlibu',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Ikon Robot Lucide + Judul AI Travel + Subjudul Oranye
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3FA),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF0066B2),
                        width: 1.6,
                      ),
                    ),
                    child: const Icon(
                      LucideIcons.bot,
                      color: Color(0xFF0066B2),
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'AI Travel',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0066B2),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Asisten pintar untuk rencana liburanmu',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFF7A00),
                    ),
                  ),
                ],
              ),
            ),

            // 2. KONTEN TENGAH
            Expanded(
              child: sudahMulaiChat
                  ? _buildChatConversation()
                  : _buildInitialPromptCards(),
            ),

            // 3. KOLOM INPUT PENCARIAN BAWAH
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF94A3B8)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(
                      LucideIcons.search,
                      size: 16,
                      color: Color(0xFF334155),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (val) =>
                            _kirimPertanyaan(customText: val),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.5,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Pertanyaan',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    if (_inputController.text.isNotEmpty)
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          LucideIcons.send,
                          size: 16,
                          color: Color(0xFF0066B2),
                        ),
                        onPressed: () =>
                            _kirimPertanyaan(customText: _inputController.text),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAMPILAN AWAL: Card Biru Muda (#EBF3FA) + Tombol Putih
  Widget _buildInitialPromptCards() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEBF3FA),
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
                const Text(
                  'Rekomendasi Pertanyaan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0066B2),
                  ),
                ),
                const SizedBox(height: 10),
                ..._rekomendasiPertanyaan.map((pertanyaan) {
                  final isSelected = _selectedPertanyaan == pertanyaan;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() => _selectedPertanyaan = pertanyaan);
                        _kirimPertanyaan();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0066B2)
                                : const Color(0xFFD0E2F5),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          pertanyaan,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Card 2: Pilih budget
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEBF3FA),
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
                const Text(
                  'Pilih budget',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF7A00),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: _pilihanBudget.map((budget) {
                    final isSelected = _selectedBudget == budget;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: budget == _pilihanBudget.last ? 0 : 8,
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() => _selectedBudget = budget);
                            _kirimPertanyaan();
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF0066B2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              budget,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAMPILAN PERCAKAPAN AKTIF
  Widget _buildChatConversation() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: _chatHistory.length,
      itemBuilder: (context, index) {
        final chat = _chatHistory[index];
        final bool isUser = chat['isUser'];
        final bool isWarning = chat['isWarning'] == true;

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.78,
            ),
            decoration: BoxDecoration(
              color: isWarning ? const Color(0xFFFFF7ED) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isWarning
                    ? const Color(0xFFFF7A00)
                    : const Color(0xFFCBD5E1),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isWarning) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 1, right: 8),
                    child: Icon(
                      LucideIcons.circleAlert,
                      size: 16,
                      color: Color(0xFFFF7A00),
                    ),
                  ),
                ],
                Flexible(
                  child: Text(
                    chat['text'],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.5,
                      height: 1.45,
                      color: isWarning
                          ? const Color(0xFF9A3412)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}