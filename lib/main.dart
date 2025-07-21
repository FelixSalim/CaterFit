import 'package:caterfit/admin/homeAdmin.dart';
import 'package:caterfit/admin/navbarAdmin.dart';
import 'package:caterfit/user/navbarUser.dart';
import 'package:caterfit/user/payment.dart';
import 'package:caterfit/user/home.dart';
import 'package:flutter/material.dart';
import 'package:caterfit/login.dart';
import 'package:caterfit/register.dart';
import 'package:caterfit/user/packageMenu.dart';
import 'package:caterfit/user/profile.dart';
import 'package:caterfit/user/preferences.dart';
import 'package:caterfit/admin/complaints.dart';
import 'package:caterfit/admin/orderDetail.dart';
import 'package:caterfit/admin/package_management.dart';
import 'package:caterfit/user/subscription.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<NavbarState> navbarAdminKey = GlobalKey<NavbarState>();
    return const MaterialApp(
      title: 'CaterFit',
      // home:Register(),
      // home: PaymentPage(),
      // home:CaterfitPackageScreen(),
      // home:HomeScreen(username: 'Carmen',),
      // home: HomeAdmin(username: 'Admin123',),
      // home: TodaysOrderDetail(),
      // home: Subscription(),
      home: LoginPage(),
      // home:PackageManagement(),
      // home: NavbarAdmin(
      //   key: navbarAdminKey,
      // ),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}
