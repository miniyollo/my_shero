import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shero/assets/constants.dart';
import 'package:my_shero/assets/widgets/customalert.dart';
import 'package:my_shero/assets/widgets/customtexticoncard.dart';
import 'package:my_shero/screens/Auth/Login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextIconCard(
          text: "Sign out",
          icon: Icons.logout_outlined,
          onTap: () async {
            try {
              await FirebaseAuth.instance.signOut();
              goTo(context, LoginPage());
            } on FirebaseAuthException catch (e) {
              dialogueBox(context, e.toString());
              
            }
          }),
    );
  }
}
