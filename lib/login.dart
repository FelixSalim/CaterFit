import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caterfit/admin/package_management.dart';
import 'package:caterfit/register.dart';

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
  String? _errorMessage; // Added for error message

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
      borderSide: const BorderSide(
          color: Color(0xFF0D3011),
          width: 1.5), // Slightly thicker stroke for text fields
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      backgroundColor:
          const Color(0xFFFEFFDE), // Changed background color to FEFFDE
      body: Stack(
        children: [
          // Logo di atas
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Opacity(
                opacity: 1,
                child: Image.asset('Assets/pnglogo.png', width: 200),
              ),
            ),
          ),

          // Container Login
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFCDE38B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Login to Your Account',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D3011),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Username
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: TextField(
                      controller: _usernameController,
                      onChanged: (_) => setState(() {
                        _errorMessage = null;
                      }),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Color(0xFF0D3011), size: 24),
                        hintText: 'Username',
                        hintStyle: GoogleFonts.nunitoSans(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFFFEFFDE),
                        border: customBorder,
                        enabledBorder: customBorder,
                        focusedBorder: customBorder,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: TextField(
                      controller: _passwordController,
                      onChanged: (_) => setState(() {
                        _errorMessage = null;
                      }),
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: Color(0xFF0D3011), size: 24),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.nunitoSans(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFFFEFFDE),
                        border: customBorder,
                        enabledBorder: customBorder,
                        focusedBorder: customBorder,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFF0D3011),
                            size: 24,
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
                  ),

                  SizedBox(
                    height: 30.0,
                    child: _errorMessage != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 9.0),
                            child: Text(
                              _errorMessage!,
                              style: GoogleFonts.nunitoSans(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : Container(), // Empty container to maintain space when no error
                  ),

                  // Remember Me + Forget Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Row(
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
                              side: const BorderSide(
                                  color: Color(0xFF0D3011), width: 1),
                              activeColor: const Color(0xFF0D3011),
                              checkColor: const Color(0xFFFEFFDE),
                            ),
                            Text(
                              'Remember Me',
                              style: GoogleFonts.nunitoSans(
                                  color: const Color(0xFF0D3011)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Implement forgot password logic
                          },
                          child: Text(
                            'Forget Password?',
                            style: GoogleFonts.nunitoSans(
                              decoration: TextDecoration.underline,
                              color: const Color(0xFF0D3011),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Space to Login button

                  // Login button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: ElevatedButton(
                      onPressed: allFieldsFilled
                          ? () {
                              if (_usernameController.text == "Admin" &&
                                  _passwordController.text == "Admin123") {
                                _errorMessage = null;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PackageManagement(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _errorMessage =
                                      "Invalid username or password";
                                });
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: allFieldsFilled
                            ? const Color(0xFF0D3011)
                            : const Color(0xFF9C9C9C),
                        foregroundColor: const Color(0xFFFEFFDE),
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
                  ),
                  const SizedBox(height: 80), // Space to Register

                  // Register
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Implement registration navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.nunitoSans(
                              color: const Color(0xFF0D3011)),
                          children: [
                            TextSpan(
                              text: "Register",
                              style: GoogleFonts.nunitoSans(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0D3011),
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

          // Back button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color(0xFF0D3011), size: 28),
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
