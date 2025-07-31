import 'dart:async';

import 'package:caterfit/admin/navbarAdmin.dart';
import 'package:caterfit/controller/accessibility_controller.dart';
import 'package:caterfit/user/navbarUser.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:caterfit/register.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String username = 'Carmen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage; // Added for error message

  String _username = '';
  String _password = '';
  stt.SpeechToText _speech = stt.SpeechToText();

  @override
  void initState() {
    super.initState();
    _announceToActivateAccessibility();
  }

  void _announceToActivateAccessibility() async {
    if (!await AccessibilityController.getIsEnabled()) {
      await AccessibilityController.speak(
          "Welcome to Caterfit, To enable accessibility mode, hold the screen for five seconds. This will allow voice feedback for better navigation.");
    }
  }

  void _announceIfAccessibility() async {
    if (await AccessibilityController.getIsEnabled()) {
      await AccessibilityController.speak('Accessibility Mode Activated');
      // Request microphone permission
      PermissionStatus status = await Permission.microphone.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        await AccessibilityController.speak(
            "Microphone permission is required for speech recognition. Please enable it in your device settings.");
        return;
      }
      await AccessibilityController.speak("Login screen. Enter your email");

      // Delay to ensure TTS finishes speaking
      await Future.delayed(const Duration(seconds: 1));

      // Start speech recognition
      bool available = await _speech.initialize();
      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              _username = result.recognizedWords;
            });
          },
          listenFor: const Duration(seconds: 10),
          pauseFor: const Duration(seconds: 1),
          partialResults: false,
        );

        // Stop the speech recognizer (just in case)
        await _speech.stop();

        // Now continue with speech
        await AccessibilityController.speak("success");
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Timer? _holdTimer;

  void _handleTouchDown(TapDownDetails details) {
    _holdTimer?.cancel();
    _holdTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        AccessibilityController.isEnabled = true;
        _announceIfAccessibility();
      });
    });
  }

  void _handleTouchUp(TapUpDetails details) {
    _holdTimer?.cancel();
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
    final GlobalKey<HomePageState> navbarKey = GlobalKey<HomePageState>();
    final GlobalKey<NavbarState> navbarAdminKey = GlobalKey<NavbarState>();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _handleTouchDown,
      onTapUp: _handleTouchUp,
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFFDE),
        body: Stack(
          children: [
            // Logo
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Semantics(
                  label: 'CaterFit Logo',
                  image: true,
                  child: Image.asset('Assets/pnglogo.png', width: 200),
                ),
              ),
            ),

            // Login Container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
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
                      child: Semantics(
                        label: 'Login to Your Account',
                        header: true,
                        child: Text(
                          'Login to Your Account',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0D3011),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Username field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Semantics(
                        label: 'Username input field',
                        hint: 'Enter your username',
                        textField: true,
                        child: TextField(
                          controller: _usernameController,
                          onChanged: (_) => setState(() {
                            _errorMessage = null;
                          }),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Color(0xFF0D3011), size: 24),
                            hintText: 'Username',
                            hintStyle:
                                GoogleFonts.nunitoSans(color: Colors.grey),
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
                    ),
                    const SizedBox(height: 20),

                    // Password field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Semantics(
                        label: 'Password input field',
                        hint:
                            'Enter your password. Double tap to toggle visibility.',
                        textField: true,
                        obscured: _obscurePassword,
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
                            hintStyle:
                                GoogleFonts.nunitoSans(color: Colors.grey),
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
                    ),

                    // Error message
                    SizedBox(
                      height: 30.0,
                      child: _errorMessage != null
                          ? Semantics(
                              label: 'Error: $_errorMessage',
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 9.0),
                                child: Text(
                                  _errorMessage!,
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),

                    // Remember Me and Forget Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Semantics(
                          label: 'Remember Me checkbox',
                          hint:
                              'Check this if you want the system to remember your login next time',
                          toggled: _rememberMe,
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
                        Semantics(
                          label: 'Forgot Password link',
                          hint: 'Double tap to recover your password',
                          button: true,
                          child: Padding(
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
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // Login button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Semantics(
                        label: 'Login button',
                        hint: 'Double tap to login to your account',
                        button: true,
                        enabled: allFieldsFilled,
                        child: ElevatedButton(
                          onPressed: allFieldsFilled
                              ? () {
                                  if (_usernameController.text == "Admin" &&
                                      _passwordController.text == "Admin123") {
                                    _errorMessage = null;
                                    LoginPage.username =
                                        _usernameController.text;
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const PackageManagement(),
                                    //   ),
                                    // );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        // TO-DO : NAVBAR ADMIN
                                        builder: (context) => NavbarAdmin(
                                          key: navbarAdminKey,
                                        ),
                                      ),
                                    );
                                  } else if (_usernameController.text ==
                                          "User" &&
                                      _passwordController.text == "User123") {
                                    _errorMessage = null;
                                    LoginPage.username =
                                        _usernameController.text;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Navbar(
                                          key: navbarKey,
                                        ),
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
                    ),

                    const SizedBox(height: 80),

                    // Register
                    Center(
                      child: Semantics(
                        label: "Don't have an account? Register link",
                        hint: 'Double tap to register a new account',
                        button: true,
                        child: GestureDetector(
                          onTap: () {
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
