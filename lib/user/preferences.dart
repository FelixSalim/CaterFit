import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caterfit/user/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferences', // Diperbarui sesuai permintaan Anda
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const PreferencesPage(),
    );
  }
}

// Definisikan warna agar mudah diubah dan digunakan kembali
const Color kPrimaryTextColor = Color(0xFF0D3011);
const Color kContainerColor = Color(0xFFFEFFDE);
const Color kUnselectedChipColor = Color(0xFFCDE38B);
const Color kSelectedChipColor = Color(0xFF0D3011);
const Color kChipTextColor = Colors.white;

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  // Daftar untuk menyimpan preferensi yang tersedia
  final List<String> dietTypes = [
    'Cutting',
    'Bulking',
    'Maintenance',
    'Lean Gain',
    'Ketogenic',
    'Vegan',
    'Paleo'
  ];

  final List<String> nutritionTypes = [
    'High Protein',
    'High Carbs',
    'High Fiber',
    'Low Fat',
    'Balanced'
  ];

  // Daftar untuk melacak preferensi yang dipilih oleh pengguna
  final List<String> _selectedDietTypes = [];
  final List<String> _selectedNutritionTypes = [];

  // Fungsi untuk menangani pemilihan chip
  void _toggleSelection(String item, List<String> selectedList) {
    setState(() {
      if (selectedList.contains(item)) {
        selectedList.remove(item);
      } else {
        selectedList.add(item);
      }
    });
  }

  // Definisikan shadow yang akan digunakan kembali
  final List<BoxShadow> kCustomShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.25),
      blurRadius: 6,
      offset: const Offset(4, 5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool hasNoPreferencesSelected =
        _selectedDietTypes.isEmpty && _selectedNutritionTypes.isEmpty;

    return Scaffold(
      // Tidak menggunakan AppBar agar header bisa ikut ter-scroll
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Kustom (Judul dan Tombol Kembali)
              Row(
                children: [
                  // Tombol kembali dengan aset kustom
                  InkWell(
                    onTap: () {
                      // Navigasi ke ProfilePage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    },
                    // Memberi area sentuh yang cukup
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                      child: Image.asset(
                        'Assets/back.png',
                        width: 32, // Diperbarui sesuai permintaan Anda
                        height: 32, // Diperbarui sesuai permintaan Anda
                        color: kPrimaryTextColor,
                      ),
                    ),
                  ),
                  // Judul halaman yang terpusat
                  Expanded(
                    child: Text(
                      'Preferences',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: kPrimaryTextColor,
                      ),
                    ),
                  ),
                  // Spacer untuk menyeimbangkan tombol kembali agar judul tetap di tengah
                  const SizedBox(width: 48), // Disesuaikan dengan padding InkWell
                ],
              ),
              // REVISI: Mengurangi jarak dari header
              const SizedBox(height: 20),

              // Pesan peringatan dengan Visibility untuk menjaga konsistensi layout
              Visibility(
                visible: hasNoPreferencesSelected,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Padding(
                  // REVISI: Mengurangi padding bawah untuk mengurangi jarak ke section
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    "You haven't selected any preferences",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.nunitoSans( // Diperbarui sesuai permintaan Anda
                      color: Colors.red[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // Section Diet Type
              _buildPreferenceSection(
                title: 'Diet Type',
                allOptions: dietTypes,
                selectedOptions: _selectedDietTypes,
              ),
              const SizedBox(height: 32),

              // Section Nutrition Type
              _buildPreferenceSection(
                title: 'Nutrition Type',
                allOptions: nutritionTypes,
                selectedOptions: _selectedNutritionTypes,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceSection({
    required String title,
    required List<String> allOptions,
    required List<String> selectedOptions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kPrimaryTextColor,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: kContainerColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: kCustomShadow, // Menambahkan shadow ke kontainer section
          ),
          child: Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: allOptions.map((option) {
              final isSelected = selectedOptions.contains(option);
              return _buildPreferenceChip(
                label: option,
                isSelected: isSelected,
                onTap: () => _toggleSelection(option, selectedOptions),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPreferenceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // REVISI: Mengurangi padding vertikal lagi untuk mengurangi tinggi kotak
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? kSelectedChipColor : kUnselectedChipColor,
          borderRadius: BorderRadius.circular(12),
          // Menambahkan shadow hanya jika chip dipilih
          boxShadow: isSelected ? kCustomShadow : [],
        ),
        child: Text(
          label,
          // Menggunakan font Nunito Sans SemiBold
          style: GoogleFonts.nunitoSans(
            color: kChipTextColor,
            fontWeight: FontWeight.w600, // SemiBold
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
