import 'package:caterfit/user/packageMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // --- HEADER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, $username!",
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D3011),
                        ),
                      ),
                      Text(
                        "Let's find your healthy meal",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15,
                          color: Color(0xFF797979),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    // backgroundImage: AssetImage('assets/profile.jpg'),
                    radius: 24,
                  )
                ],
              ),

              // --- CAROUSEL ---
              SizedBox(height: 20),
              PromoCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

class PromoCarousel extends StatelessWidget {
  final PageController _pageController = PageController(viewportFraction: 1);

  PromoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Container luar
    return Container(
      height: 197,
      // margin: EdgeInsets.only(bottom: 20),
      child: PageView.builder(
        controller: _pageController,
        itemCount: 2, // jumlah item promo
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // child: _buildPromoCard(index),
            child: index == 0 ? _buildPromoCard1(context) : _buildPromoCard2(),
          );
        },
      ),
    );
  }

  // --- PROMOTION ---
  Widget _buildPromoCard1(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFFDE),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --- TEXT & BUTTON ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "50%",
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0D3011),
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 4),
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Discount packages",
                        style: TextStyle(
                          color: Color(0xFF0D3011),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // --- BUTTON ---
                      const SizedBox(height: 2),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CaterfitPackageScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D3011),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          elevation: 4,
                          shadowColor: Colors.black38,
                        ),
                        child: const Text(
                          "Subscribe Now",
                          style: TextStyle(
                            color: Color(0xFFFEFFDE),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 140), // Space to make room for image
              ],
            ),
          ),

          // --- POSITIONED IMAGE ---
          Positioned(
            right: -20,
            top: -50,
            child: Image.asset(
              'Assets/promotion.png',
              height: 215,
            ),
          ),
        ],
      ),
    );
  }

  // --- HEALTH INFO ---
  Widget _buildPromoCard2() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFFDE),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --- TEXT & BUTTON ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Healthy Life Tips",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0D3011),
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 4),
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),

                      // TO-DO Ricky : Masukin point tips makan sehat 1-5
                      const Text(
                        "1. Eat 3 meals a day + healthy snacks (fruits, nuts) ",
                        style: TextStyle(
                          color: Color(0xFF0D3011),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 100), // Space to make room for image
              ],
            ),
          ),

          // --- POSITIONED IMAGE ---
          Positioned(
            right: -5,
            top: -22,
            child: Image.asset(
              'Assets/quickTips.png',
              height: 104,
            ),
          ),
        ],
      ),
    );
  }
}
