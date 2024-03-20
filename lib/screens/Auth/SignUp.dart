import 'package:flutter/material.dart';
import 'package:my_shero/screens/Auth/Login.dart';
import 'package:my_shero/screens/locations/locations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../assets/theme.dart';
import '../../assets/widgets/custombutton.dart';
import '../../assets/widgets/customclipper.dart';
import '../../assets/widgets/customtextfield.dart';
import 'authservices.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _phoneController =
  //     TextEditingController(); // Might not be needed for sign-up

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
                  height: 250,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    CustomTextField(
                      hintText: 'Enter Email ID',
                      controller: _emailController,
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      icon: Icons.lock,
                    ),
                    // Consider removing or repurposing the phone field for sign-up
                    const SizedBox(height: 32),
                    CustomButton(
                      text: 'Sign Up',
                      onPressed: () async {
                        try {
                          User? user = await AuthService()
                              .createUserWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (user != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SafePlacesPage()));
                          }
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.message ??
                                  'Registration failed. Please try again.')));
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      ), // Navigate to the LoginPage
                      child: const Text(
                        'Already have an account? Login',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
