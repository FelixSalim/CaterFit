import 'dart:io';
import 'package:caterfit/admin/complaints.dart';
import 'package:caterfit/admin/navbarAdmin.dart';
import 'package:caterfit/admin/orderDetail.dart';
import 'package:caterfit/admin/package_management.dart';
import 'package:caterfit/admin/subscriber.dart';
import 'package:caterfit/user/navbarUser.dart';
import 'package:caterfit/user/packageMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caterfit/login.dart';


class HomeAdmin extends StatelessWidget {
  final String username;
  const HomeAdmin({super.key, required this.username});

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
                        "Welcome back",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF0D3011),
                        ),
                      ),
                      Text(
                        "$username",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Color(0xFF0D3011),
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                      print('Logout pressed, navigating to LoginPage');
                    },
                    icon: const Icon(Icons.logout, color: Colors.white, size: 20),
                    label: Text(
                      'Log Out',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D3011),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SUBSCRIBER MENU
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriberPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF0D3011)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF0D3011),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.group,
                              size: 32,
                              color: Color(0xFFCDE38B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Subscriber",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0D3011),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // COMPLAINTS BUTTON
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatApp(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF0D3011)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF0D3011),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.chat,
                              size: 32,
                              color: Color(0xFFCDE38B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Complaints",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0D3011),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                "Today's Order Summary",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D3011)),
              ),
              SizedBox(height: 20),
              // BULKING PACKAGE
              InkWell(
                onTap: () {
                  NavbarAdmin.of(context)?.changeTab(2);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xFF0D3011)), // warna hijau gelap
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D3011),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(Icons.fitness_center,
                            size: 47,
                            color: Color(0xFFCDE38B)), // icon subscriber
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bulking Package",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0D3011),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "You have 1 package to deliver today",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0D3011)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              // CUTTING PACKAGE
              InkWell(
                onTap: () {
                  NavbarAdmin.of(context)?.changeTab(2);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xFF0D3011)), // warna hijau gelap
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D3011),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_downward,
                            size: 47,
                            color: Color(0xFFCDE38B)), // icon subscriber
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cutting Package",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0D3011),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "You have 1 package to deliver today",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0D3011)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              // BACK 2 SCHOOL
              InkWell(
                onTap: () {
                  NavbarAdmin.of(context)?.changeTab(2);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xFF0D3011)), // warna hijau gelap
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D3011),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(Icons.school_rounded,
                            size: 47,
                            color: Color(0xFFCDE38B)), // icon subscriber
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Back 2 School Package",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0D3011),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "You have no packages to deliver today",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0D3011)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Recently Added Packages",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D3011)),
              ),
              SizedBox(height: 20),
              PackageCardFront()
            ],
          ),
        ),
      ),
    );
  }
}

class PackageCardFront extends StatelessWidget {
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
        child: Image.asset('Assets/PackageImageTemp.png', fit: BoxFit.cover),
      ),
    );
  }
}

