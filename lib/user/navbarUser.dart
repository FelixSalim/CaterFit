import 'package:caterfit/login.dart';
import 'package:caterfit/user/packageMenu.dart';
import 'package:caterfit/user/home.dart';
import 'package:caterfit/user/profile.dart';
import 'package:caterfit/user/subscription.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  static HomePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<HomePageState>();

  @override
  State<Navbar> createState() => HomePageState();
}

class HomePageState extends State<Navbar> {
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> body = [
    HomeScreen(
      username: LoginPage.username,
    ),
    const CaterfitPackageScreen(),
    const Subscription(),
    const ProfilePage(),
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
        // bottomNavigationBar: CurvedNavigationBar(
        //   key: _bottomNavigationKey,
        //   index: 0,
        //   items: const [
        //     Icon(Icons.home_outlined, color: Color(0xFFFEFFDE)),
        //     Icon(Icons.restaurant_menu,
        //         color: Color(0xFFFEFFDE)), // Ganti dari chat ke knife/fork
        //     Icon(Icons.history, color: Color(0xFFFEFFDE)),
        //     Icon(Icons.person, color: Color(0xFFFEFFDE)),
        //   ],

        //   color: Color(0xFF0D3011),
        //   buttonBackgroundColor: Color(0xFFCDE38B),
        //   backgroundColor: Color(0xFF0D3011),
        //   // animationCurve: Curves.easeInOut,
        //   animationDuration: const Duration(milliseconds: 600),
        //   onTap: (index) {
        //     setState(() {
        //       page = index;
        //     });
        //   },
        //   letIndexChange: (index) => true,
        // ),

        body: body[page],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: page,
            onTap: (index) {
              setState(() {
                page = index;
              });
            },
            backgroundColor: Color(0xFF0D3011),
            selectedItemColor: Color(0xFFFEFFDE),
            unselectedItemColor: const Color(0xFFFEFFDE),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            unselectedIconTheme:
                const IconThemeData(size: 32), // Default icon size

            selectedIconTheme: const IconThemeData(
              size: 32,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.green,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            items: [
              BottomNavigationBarItem(
                icon: _navIcon(Icons.home_rounded, selected: page == 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _navIcon(Icons.restaurant_menu, selected: page == 1),
                label: 'Dining',
              ),
              BottomNavigationBarItem(
                icon: _navIcon(Icons.history, selected: page == 2),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: _navIcon(Icons.person, selected: page == 3),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }

  Widget _navIcon(IconData icon, {required bool selected}) {
    return Container(
      decoration: selected
          ? BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFCDE38B), // Lingkaran highlight
            )
          : null,
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: selected ? const Color(0xFFFEFFDE) : const Color(0xFFFEFFDE),
      ),
    );
  }
}
