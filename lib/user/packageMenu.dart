import 'package:flutter/material.dart';
import 'package:caterfit/user/packageDetail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class CaterfitPackage {
  final String name;
  final int price;
  final String imageUrl;
  final List<String> categories;

  CaterfitPackage({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.categories,
  });
}

class CaterfitPackageScreen extends StatefulWidget {
  const CaterfitPackageScreen({super.key});

  @override
  State<CaterfitPackageScreen> createState() => _CaterfitPackageScreenState();
}

class _CaterfitPackageScreenState extends State<CaterfitPackageScreen> {
  // --- STATE MANAGEMENT ---
  final List<String> _categories = [
    'Hot Deals',
    'Bulking',
    'Cutting',
    'Back 2 School'
  ];

  String _selectedCategory = 'Hot Deals';

  final List<CaterfitPackage> _allPackages = [
    CaterfitPackage(
      name: 'Muscle Meal',
      price: 400000,
      imageUrl: 'Assets/musclemeal.jpg',
      categories: ['Hot Deals', 'Bulking'],
    ),
    CaterfitPackage(
      name: 'Eastern Delights',
      price: 350000,
      imageUrl: 'Assets/easterndelights.jpg',
      categories: ['Hot Deals', 'Cutting'],
    ),
    CaterfitPackage(
      name: 'Office Bites',
      price: 290000,
      imageUrl: 'Assets/officebites.jpg',
      categories: ['Back 2 School', 'Hot Deals'],
    ),
    CaterfitPackage(
      name: 'Carbo Charge',
      price: 350000,
      imageUrl: 'Assets/carbocharge.jpg',
      categories: ['Bulking', 'Hot Deals'],
    ),
    CaterfitPackage(
      name: 'Lil\' Lunch Pack',
      price: 300000,
      imageUrl: 'Assets/lillunchpack.jpg',
      categories: ['Hot Deals', 'Back 2 School'],
    ),
    CaterfitPackage(
      name: 'Gains on the Go',
      price: 500000,
      imageUrl: 'Assets/musclemeal.jpg',
      categories: ['Bulking', 'Hot Deals'],
    ),
  ];

  List<CaterfitPackage> _filteredPackages = [];

  final formatCurrency = intl.NumberFormat.currency(
      locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _filterPackages();
  }

  // --- LOGIC ---
  void _filterPackages() {
    setState(() {
      _filteredPackages = _allPackages
          .where((package) => package.categories.contains(_selectedCategory))
          .toList();
    });
  }

  // --- UI DEFINITIONS ---
  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF0D3011);
    const Color lightYellow = Color(0xFFFEFFDE);
    const Color cardGreen = Color(0xFFCDE38B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Caterfit Package',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. Widget untuk slide bar kategori
          _buildCategorySelector(darkGreen, lightYellow, cardGreen),

          // 2. Widget untuk menampilkan grid kartu paket
          _buildPackageGrid(cardGreen, darkGreen),
        ],
      ),
    );
  }

  Widget _buildCategorySelector(
      Color darkGreen, Color lightYellow, Color cardGreen) {
    return Container(
      height: 64,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final bool isSelected = category == _selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
                _filterPackages();
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: isSelected ? cardGreen : lightYellow,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2), // Posisi bayangan
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPackageGrid(Color cardGreen, Color darkGreen) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemCount: _filteredPackages.length,
        itemBuilder: (context, index) {
          final package = _filteredPackages[index];
          return _buildPackageCard(package, cardGreen, darkGreen);
        },
      ),
    );
  }

  Widget _buildPackageCard(
      CaterfitPackage package, Color cardGreen, Color darkGreen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetailScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 2),
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  package.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey));
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: cardGreen,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        package.name,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: darkGreen,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatCurrency.format(package.price),
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: darkGreen,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
