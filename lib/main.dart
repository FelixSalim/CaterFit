import 'package:caterfit/user/home.dart';
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
      // home: LoginPage(),
      home: HomeScreen(username: 'Carmen'),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}
