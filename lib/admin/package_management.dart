import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageManagement extends StatelessWidget {
  const PackageManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          PackageManagementTitle(),
        ],
      ),
    );
  }
}

class PackageManagementTitle extends StatelessWidget {
  const PackageManagementTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Package Management",
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
