import 'package:caterfit/navbar.dart';
import 'package:caterfit/user/payment.dart';
import 'package:caterfit/user/home.dart';
import 'package:flutter/material.dart';
import 'package:caterfit/login.dart';
import 'package:caterfit/register.dart';
import 'package:caterfit/user/packageMenu.dart';
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
    return const MaterialApp(
      title: 'CaterFit',
      // home: LoginPage(),
      // home:Register(),
      // home: PaymentPage(),
      // home:CaterfitPackageScreen(),
      home:HomeScreen(username: 'Carmen',),
      //home: LoginPage(),
      // home: TodaysOrderDetail(),
      // home: Subscription(),
      // home:PackageManagement(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}
