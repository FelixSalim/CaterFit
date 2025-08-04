import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caterfit/user/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferences',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const PreferencesPage(),
    );
  }
}

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

  List<String> _selectedDietTypes = [];
  List<String> _selectedNutritionTypes = [];
  bool _isLoading = true; // State untuk menunjukkan apakah data sedang dimuat

  final List<BoxShadow> kCustomShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.25),
      blurRadius: 6,
      offset: const Offset(4, 5),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Fungsi untuk memuat preferensi dari shared_preferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedDietTypes = prefs.getStringList('selectedDietTypes') ?? [];
      _selectedNutritionTypes =
          prefs.getStringList('selectedNutritionTypes') ?? [];
      _isLoading = false; // Setelah data dimuat, set isLoading menjadi false
    });
  }

  // Fungsi untuk menyimpan preferensi ke shared_preferences
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedDietTypes', _selectedDietTypes);
    prefs.setStringList('selectedNutritionTypes', _selectedNutritionTypes);
  }

  void _toggleSelection(String item, List<String> selectedList) {
    setState(() {
      if (selectedList.contains(item)) {
        selectedList.remove(item);
      } else {
        selectedList.add(item);
      }
      _savePreferences(); // Panggil fungsi simpan setiap kali pilihan berubah
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasNoPreferencesSelected =
        _selectedDietTypes.isEmpty && _selectedNutritionTypes.isEmpty;

    return Scaffold(
<<<<<<< Updated upstream
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
                      Navigator.pop(context);
                    },
                    // Memberi area sentuh yang cukup
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                      child: Image.asset(
                        'Assets/back.png',
                        width: 32, // Diperbarui sesuai permintaan Anda
                        height: 32, // Diperbarui sesuai permintaan Anda
                        color: kPrimaryTextColor,
=======
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Tampilkan loading indicator
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                            child: Image.asset(
                              'Assets/back.png',
                              width: 32,
                              height: 32,
                              color: kPrimaryTextColor,
                            ),
                          ),
                        ),
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
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: hasNoPreferencesSelected,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "You haven't selected any preferences",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunitoSans(
                            color: Colors.red[800],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
>>>>>>> Stashed changes
                      ),
                    ),
                    _buildPreferenceSection(
                      title: 'Diet Type',
                      allOptions: dietTypes,
                      selectedOptions: _selectedDietTypes,
                    ),
<<<<<<< Updated upstream
                  ),
                  // Spacer untuk menyeimbangkan tombol kembali agar judul tetap di tengah
                  const SizedBox(
                      width: 48), // Disesuaikan dengan padding InkWell
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
                    style: GoogleFonts.nunitoSans(
                      // Diperbarui sesuai permintaan Anda
                      color: Colors.red[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
=======
                    const SizedBox(height: 32),
                    _buildPreferenceSection(
                      title: 'Nutrition Type',
                      allOptions: nutritionTypes,
                      selectedOptions: _selectedNutritionTypes,
>>>>>>> Stashed changes
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
            boxShadow: kCustomShadow,
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? kSelectedChipColor : kUnselectedChipColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? kCustomShadow : [],
        ),
        child: Text(
          label,
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