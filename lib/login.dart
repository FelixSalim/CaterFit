import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    bool isFormFilled =
        _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFFDE),
      body: Stack(
        children: [
          // Transparent logo in background
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/logo.png', // Sesuaikan path asset logo CaterFit
                height: 120,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Main logo
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),

                  const SizedBox(height: 20),

                  // Login Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Login To Your Account',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Username Field
                        TextField(
                          controller: _usernameController,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        TextField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Remember Me & Forgot Password
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
                                ),
                                const Text('Remember Me'),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigasi ke halaman lupa password
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isFormFilled
                                ? () {
                                    // Aksi login
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFormFilled
                                  ? const Color(0xFFCDE38B)
                                  : Colors.grey.shade300,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman register
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
