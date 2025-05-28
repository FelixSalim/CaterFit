import 'package:flutter/material.dart';

import 'package:caterfit/register.dart';
import 'package:caterfit/admin/package_management.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CaterFit Login'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PackageManagement()));
              },
              child: const Text('Login')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Register()));
              },
              child: const Text("Don't have account? Register")),
        ],
      ),
    );
  }
}
