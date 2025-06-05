import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageManagement extends StatelessWidget {
  const PackageManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PackageManagementTitle(),
          OnGoingPackage(),
        ],
      ),
    );
  }
}

class PackageManagementTitle extends StatelessWidget {
  const PackageManagementTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 24, bottom: 20),
      child: Text(
        "Package Management",
        style: GoogleFonts.montserrat(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

class OnGoingPackage extends StatelessWidget {
  const OnGoingPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [OnGoingPackageTitle()],
        ),
        Row(
          children: [OnGoingPackageCards()],
        ),
      ],
    );
  }
}

class OnGoingPackageTitle extends StatelessWidget {
  const OnGoingPackageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        "On Going Package",
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

class OnGoingPackageCards extends StatelessWidget {
  const OnGoingPackageCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: const Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PackageCard(
                  title: "School Meal Package", image: "PackageImageTemp.png"),
              PackageCard(
                  title: "School Meal Package", image: "PackageImageTemp.png"),
            ],
          ),
          Row(
            children: [
              PackageCard(
                  title: "School Meal Package", image: "PackageImageTemp.png"),
              PackageCard(
                  title: "School Meal Package", image: "PackageImageTemp.png"),
            ],
          ),
        ]));
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String image;

  const PackageCard({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: -3,
                blurRadius: 4,
                offset: const Offset(4, 4), // changes position of shadow
              )
            ]),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Card(
          child: Image.asset('Assets/$image', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
