import 'package:caterfit/login.dart';
import 'package:caterfit/user/packageMenu.dart';
import 'package:caterfit/user/payment.dart';
import 'package:caterfit/user/home.dart';
import 'package:caterfit/user/subscription.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final Function(int)? onTabChanged;
  const Navbar({super.key, this.onTabChanged});

  @override
  State<Navbar> createState() => HomePageState();
}

class HomePageState extends State<Navbar> {
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> body = [
    HomeScreen(
      username: LoginPage.username,
    ), // Sesuaikan dengan nama file kamu
    const CaterfitPackageScreen(),
    const Subscription(),
    // Nanti ganti jadi profile
    const PaymentPage(
      weeks: 2,
    ),
  ];
  void changeTab(int index) {
    if (mounted) {
      setState(() {
        page = index;
      });

      final navBarState = _bottomNavigationKey.currentState;
      if (navBarState != null) {
        navBarState.setPage(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const [
          Icon(CupertinoIcons.home, color: Color(0xFFFEFFDE)),
          Icon(CupertinoIcons.list_bullet,
              color: Color(0xFFFEFFDE)), // Ganti dari chat ke knife/fork
          Icon(CupertinoIcons.time, color: Color(0xFFFEFFDE)),
          Icon(CupertinoIcons.person, color: Color(0xFFFEFFDE)),
        ],
        color: Colors.white,
        buttonBackgroundColor: Color(0xFFCDE38B),
        backgroundColor: Color(0xFF0D3011),
        // animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: body[page],
    );
  }
}
