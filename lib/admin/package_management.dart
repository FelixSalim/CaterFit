import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageManagement extends StatelessWidget {
  const PackageManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PackageManagementTitle(),
            OnGoingPackage(),
            ArchivedPackage(),
          ],
        ),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String text;

  const SubTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
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
          children: [SubTitle(text: "On Going Package")],
        ),
        Row(
          children: [OnGoingPackageCards()],
        ),
      ],
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
      child: Stack(
        children: [
          PackageCardFront(title: title, image: image),
          PackageCardBack(title: title, image: image),
        ],
      ),
    );
  }
}

class PackageCardFront extends StatelessWidget {
  final String title;
  final String image;

  const PackageCardFront({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 200,
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
      margin: const EdgeInsets.all(8.0),
      child: Card(
        child: Image.asset('Assets/$image', fit: BoxFit.cover),
      ),
    );
  }
}

class PackageCardBack extends StatelessWidget {
  final String title;
  final String image;

  const PackageCardBack({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 200,
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xBF0D3011),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 24),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child:
                      const Icon(Icons.archive, color: Colors.white, size: 24),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ArchivedPackage extends StatelessWidget {
  const ArchivedPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [SubTitle(text: "Archived Package")],
        ),
        Row(
          children: [ArchivedPackageCards()],
        ),
      ],
    );
  }
}

class ArchivedPackageCards extends StatelessWidget {
  const ArchivedPackageCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: const Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArchiveCard(
                  title: "School Meal Package", image: "PackageImageTemp.png"),
              ArchiveCard(
                  title: "School Meal Package", image: "PackageImageTemp.png"),
            ],
          )
        ]));
  }
}

class ArchiveCard extends StatelessWidget {
  final String title;
  final String image;

  const ArchiveCard({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ArchiveCardFront(title: title, image: image),
          ArchiveCardBack(title: title, image: image),
        ],
      ),
    );
  }
}

class ArchiveCardFront extends StatelessWidget {
  final String title;
  final String image;

  const ArchiveCardFront({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 200,
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
      margin: const EdgeInsets.all(8.0),
      child: Card(
        child: Image.asset('Assets/$image', fit: BoxFit.cover),
      ),
    );
  }
}

class ArchiveCardBack extends StatelessWidget {
  final String title;
  final String image;

  const ArchiveCardBack({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 200,
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xBF0D3011),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: const Icon(Icons.undo, color: Colors.white, size: 24),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child:
                      const Icon(Icons.delete, color: Colors.white, size: 24),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
