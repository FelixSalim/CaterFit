import 'package:caterfit/admin/homeAdmin.dart';
import 'package:caterfit/admin/orderDetail.dart';
import 'package:caterfit/admin/package_management.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({Key? key}) : super(key: key);

  static NavbarState? of(BuildContext context) =>
      context.findAncestorStateOfType<NavbarState>();

  @override
  State<NavbarAdmin> createState() => NavbarState();
}

class NavbarState extends State<NavbarAdmin> {
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> body = [
    // TO-DO : navigation to other pages
    HomeAdmin(username: "Admin123"),
    PackageManagement(),
    TodaysOrderDetail(),
    // ProfileAdmin()
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
            backgroundColor: Color(0xFFFFFFFF),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            unselectedIconTheme:
                const IconThemeData(size: 32), // Default icon size

            selectedIconTheme: const IconThemeData(
              size: 32,
              color: Color(0xFF0D3011),
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black,
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
                label: 'Management',
              ),
              BottomNavigationBarItem(
                icon: _navIcon(Icons.format_list_numbered, selected: page == 2),
                label: 'Orderlist',
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
              color: const Color(0xFF0D3011), // Lingkaran highlight
            )
          : null,
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: selected ? const Color(0xFFCDE38B) : const Color(0xFF0D3011),
      ),
    );
  }
}
