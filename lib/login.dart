import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool allFieldsFilled = _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;

    OutlineInputBorder customBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 1),
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Logo di atas
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Opacity(
                opacity: 1,
                child: Image.asset('assets/pnglogo.png', width: 200),
              ),
            ),
          ),

          // Container Login
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Color(0xFFCDE38B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Login to Your Account',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Username
                  TextField(
                    controller: _usernameController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: 'Username',
                      hintStyle: GoogleFonts.nunitoSans(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: customBorder,
                      enabledBorder: customBorder,
                      focusedBorder: customBorder,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    style: GoogleFonts.nunitoSans(),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextField(
                    controller: _passwordController,
                    onChanged: (_) => setState(() {}),
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.nunitoSans(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: customBorder,
                      enabledBorder: customBorder,
                      focusedBorder: customBorder,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    style: GoogleFonts.nunitoSans(),
                  ),
                  const SizedBox(height: 12),

                  // Remember Me + Forget Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: const BorderSide(color: Colors.black, width: 1),
                          ),
                          Text(
                            'Remember Me',
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forget Password?',
                          style: GoogleFonts.nunitoSans(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Tombol Login
                  ElevatedButton(
                    onPressed: allFieldsFilled ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: allFieldsFilled
                          ? const Color(0xFF0D3011)
                          : Colors.white,
                      foregroundColor:
                          allFieldsFilled ? Colors.white : Colors.black,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Register
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text.rich(
                        TextSpan(
                          text: "Don’t have an account? ",
                          style: GoogleFonts.nunitoSans(),
                          children: [
                            TextSpan(
                              text: "Register",
                              style: GoogleFonts.nunitoSans(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tombol Kembali
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DIBERIKAN SNIPPET CODE FLUTTER DIATAS NAMUN DITEMUKAN BBRP KENDALA
// PERBAIKI SEHINGGA
// - textcontroller bisa digunakan sehingga bisa mengetik
// - hide & see password (icon mata) bisa digunakan
// - check & uncheck remember me

// BERIKAN YG SIAP DICOPY