// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shero/screens/locations/locations.dart';

import '../../assets/theme.dart';
import '../../assets/widgets/custombutton.dart';
import '../../assets/widgets/customclipper.dart';
import '../../assets/widgets/customtextfield.dart';
import 'authservices.dart';

// Import your app theme

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() =>
      _LoginPageState(); // This is correct if it's in the same file
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: 250, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 236, 72, 70),
                        AppTheme.secondaryColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                      // child: Container(
                      //   // Placeholder for the logo
                      //   width: 100,
                      //   height: 100,
                      //   decoration: const BoxDecoration(
                      //     // Replace with your logo image
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/logo.png'),
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // You need a Column widget here to contain the multiple widgets below
                    children: [
                      const SizedBox(height: 32),

                      CustomTextField(
                        hintText: 'Enter Email ID',
                        controller: _emailController,
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required.';
                          }
                          if (!RegExp(r"\S+@\S+\.\S+").hasMatch(value)) {
                            return 'Invalid email format.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: 'Password',
                        controller: _passwordController,
                        obscureText: true,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required.';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long.';
                          }
                          // Add more password strength checks as needed
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      CustomTextField(
                          hintText: 'Contact',
                          controller: _phoneController,
                          obscureText: false,
                          icon: Icons.phone,
                          suffixIcon: Icons.arrow_forward_ios,
                          keyboardType: TextInputType.phone),

                      const SizedBox(height: 32),

                      CustomButton(
                        text: 'Sign In',
                        onPressed: () async {
                          User? user =
                              await AuthService().signInWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (user != null) {
                            // Replace 'HomePage' with the actual class of your home screen
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SafePlacesPage()));
                          } else {
                            // Show an error message
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Login failed. Please try again.')));
                          }
                        },
                      ),

                      const SizedBox(height: 16),
                      const Text('Or continue with'),
                      const SizedBox(height: 16),
                      // S,ocial buttons here
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Icons for social media login (These should ideally be wrapped in a GestureDetector or IconButton for functionality)
                          Icon(Icons.facebook),
                          Icon(Icons.apple),
                          Icon(Icons.mail_outline),
                        ],
                      ),
                      const SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Sign up screen
                        },
                        child: const Text(
                          'Existing User? Login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
