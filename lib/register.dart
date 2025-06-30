import 'package:caterfit/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isChecked = false;
  // final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder customBorder = OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color(0xFF0D3011),
          width: 1.5), // Slightly thicker stroke for text fields
      borderRadius: BorderRadius.circular(10),
    );

    void handleRegister() {
      final email = emailController.text.trim();
      final username = usernameController.text.trim();
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      // Manual validations
      if (email.isEmpty ||
          username.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        setState(() {
          errorText = "All fields are required.";
        });
        return;
      }

      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        setState(() {
          errorText = "Enter a valid email.";
        });
        return;
      }

      if (password != confirmPassword) {
        setState(() {
          errorText = "Passwords do not match.";
        });
        return;
      }

      if (!isChecked) {
        setState(() {
          errorText = "You must agree to the terms and services.";
        });
      } else {
        setState(() {
          errorText = null; // reset error
        });
        // Proceed with registration logic
        Navigator.pop(context); // Close the registration page

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFEFFDE),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SafeArea(
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    icon: const Icon(Icons.arrow_back,
                        color: Color(0xFF0D3011), size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Image.asset(
                'Assets/pnglogo.png',
                height: 200,
                width: 200,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: Color(0xFFCDE38B),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                // height: MediaQuery.of(context).size.height / 1.5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          'Create New Account',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0D3011),
                          ),
                        ),
                      ),

                      // Input Email
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: TextField(
                          controller: emailController,
                          onChanged: (_) => setState(() {
                            errorText = null;
                          }),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFEFFDE),
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Color(0xFF0D3011), size: 24),
                            hintText: 'Email',
                            hintStyle: GoogleFonts.nunitoSans(
                                color: Color(0xFF797979)),
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

                      // Input Username
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: TextField(
                          controller: usernameController,
                          onChanged: (_) => setState(() {
                            errorText = null;
                          }),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFEFFDE),
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Color(0xFF0D3011), size: 24),
                            hintText: 'Username',
                            hintStyle: GoogleFonts.nunitoSans(
                                color: const Color(0xFF797979)),
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

                      //Input Password
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: TextField(
                          controller: passwordController,
                          onChanged: (_) => setState(() {
                            errorText = null;
                          }),
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFEFFDE),
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Color(0xFF0D3011), size: 24),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.nunitoSans(
                                color: Color(0xFF797979)),
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

                      //Confirm Password
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: TextField(
                          controller: confirmPasswordController,
                          onChanged: (_) => setState(() {
                            errorText = null;
                          }),
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFEFFDE),
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Color(0xFF0D3011), size: 24),
                            hintText: 'Confirm Password',
                            hintStyle: GoogleFonts.nunitoSans(
                                color: Color(0xFF797979)),
                            border: customBorder,
                            enabledBorder: customBorder,
                            focusedBorder: customBorder,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF0D3011),
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          style: GoogleFonts.nunitoSans(),
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                        child: errorText != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 9.0),
                                child: Text(
                                  errorText!,
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : Container(), // Empty container to maintain space when no error
                      ),

                      // I agree button

                      CheckboxListTile(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        title: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                color: Color(0xFF0D3011), fontSize: 16),
                            children: [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'terms and services',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0XFF0D3011),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: const BorderSide(
                            color: Color(0xFF0D3011), width: 1),
                        activeColor: const Color(0xFF0D3011),
                        checkColor: const Color(0xFFFEFFDE),
                      ),

                      ElevatedButton(
                        onPressed: handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0D3011),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: const Color(0xFFFEFFDE),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Implement login navigation
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              style: GoogleFonts.nunitoSans(
                                  color: const Color(0xFF0D3011)),
                              children: [
                                TextSpan(
                                  text: "Login",
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
            ],
          ),
        ),
      ),
    );
  }
}
