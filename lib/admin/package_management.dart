import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caterfit/admin/add_package.dart';
import 'package:caterfit/admin/edit_package.dart';
import 'package:caterfit/models/package_model.dart';

class PackageManagement extends StatelessWidget {
  const PackageManagement({super.key});
  static int lastId = 2;

  static List<Package> onGoingPackages = [];

  static List<Package> archivedPackages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const SingleChildScrollView(
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
          ),
          Positioned(
            bottom: 50,
            right: 25,
            child: Container(
              width: 75,
              height: 75,
              decoration: const BoxDecoration(
                color: Color(0xFF0D3011),
                borderRadius: BorderRadius.all(Radius.circular(37.5)),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPackage(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                color: Colors.white,
                iconSize: 50,
              ),
            ),
          )
        ],
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
    return Padding(
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
    return Padding(
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
    var colChild = [];
    var curRow = [];
    for (var i = 0; i < PackageManagement.onGoingPackages.length; i++) {
      if (i % 2 == 0) {
        curRow.add(PackageCard(
          title: PackageManagement.onGoingPackages[i].name,
          image: PackageManagement.onGoingPackages[i].imageUrl,
        ));
      } else {
        curRow.add(PackageCard(
          title: PackageManagement.onGoingPackages[i].name,
          image: PackageManagement.onGoingPackages[i].imageUrl,
        ));
        colChild.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.from(curRow),
        ));
        curRow = [];
      }
    }
    if (curRow.isNotEmpty) {
      colChild.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.from(curRow),
      ));
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
      child: Column(
        children: List<Widget>.from(colChild),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final File image;

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
  final File image;

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
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -3,
              blurRadius: 4,
              offset: const Offset(4, 4), // changes position of shadow
            )
          ]),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: Image.file(image, fit: BoxFit.cover),
      ),
    );
  }
}

class PackageCardBack extends StatelessWidget {
  final String title;
  final File image;

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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xBF0D3011),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle edit action
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPackage(
                            packageData: PackageManagement.onGoingPackages
                                .firstWhere((pkg) => pkg.name == title),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D3011),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle archive action
                      PackageManagement.archivedPackages.add(PackageManagement
                          .onGoingPackages
                          .firstWhere((pkg) => pkg.name == title));
                      PackageManagement.onGoingPackages
                          .removeWhere((pkg) => pkg.name == title);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$title has been archived.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PackageManagement(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D3011),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(
                      Icons.archive,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
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
          children: [
            Padding(
              padding: EdgeInsets.only(top: 17.0),
              child: SubTitle(text: "Archived Package"),
            )
          ],
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
    var colChild = [];
    var curRow = [];
    for (var i = 0; i < PackageManagement.archivedPackages.length; i++) {
      if (i % 2 == 0) {
        curRow.add(ArchiveCard(
          title: PackageManagement.archivedPackages[i].name,
          image: PackageManagement.archivedPackages[i].imageUrl,
        ));
      } else {
        curRow.add(ArchiveCard(
          title: PackageManagement.archivedPackages[i].name,
          image: PackageManagement.archivedPackages[i].imageUrl,
        ));
        colChild.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.from(curRow),
        ));
        curRow = [];
      }
    }
    if (curRow.isNotEmpty) {
      colChild.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.from(curRow),
      ));
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
      child: Column(
        children: List<Widget>.from(colChild),
      ),
    );
  }
}

class ArchiveCard extends StatelessWidget {
  final String title;
  final File image;

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
  final File image;

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
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -3,
              blurRadius: 4,
              offset: const Offset(4, 4), // changes position of shadow
            )
          ]),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: Image.file(image, fit: BoxFit.cover),
      ),
    );
  }
}

class ArchiveCardBack extends StatelessWidget {
  final String title;
  final File image;

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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xBF0D3011),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle undo action
                      PackageManagement.onGoingPackages.add(PackageManagement
                          .archivedPackages
                          .firstWhere((pkg) => pkg.name == title));
                      PackageManagement.archivedPackages
                          .removeWhere((pkg) => pkg.name == title);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$title has been restored.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PackageManagement(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D3011),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(
                      Icons.undo,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3011),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle delete action
                      PackageManagement.archivedPackages
                          .removeWhere((pkg) => pkg.name == title);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$title has been deleted.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PackageManagement(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D3011),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
