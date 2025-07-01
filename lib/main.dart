import 'package:flutter/material.dart';
import 'package:caterfit/login.dart';
import 'package:caterfit/packageMenu.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CaterFit',
      home: LoginPage(),
      // home: CaterfitPackageScreen(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}
