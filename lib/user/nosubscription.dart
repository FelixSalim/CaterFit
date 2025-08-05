import 'package:caterfit/user/navbarUser.dart';
import 'package:caterfit/user/packageMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoSubscriptionPage extends StatelessWidget {
  const NoSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<HomePageState> navbarKey = GlobalKey<HomePageState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'Assets/pnglogo.png', // Make sure the path matches your asset
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 30),

              // Text message
              Text(
                "You haven't subscribed\nto any package yet :(",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D3011),
                ),
              ),
              const SizedBox(height: 30),

              // Subscribe Now Button
              ElevatedButton(
                onPressed: () {
                  Navbar.of(context)?.changeTab(1); // Navigate to Package Menu
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D3011),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Subscribe Now!",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
