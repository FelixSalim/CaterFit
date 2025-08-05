import 'package:caterfit/user/home.dart';
import 'package:caterfit/user/navbarUser.dart';
import 'package:flutter/material.dart';
import 'package:caterfit/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      // home: Navbar(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}
