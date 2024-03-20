import 'package:flutter/material.dart';
import 'package:my_shero/homepage.dart';
import 'package:my_shero/screens/Auth/SignUp.dart';
import 'package:my_shero/screens/SendSms/smssend.dart';
import 'package:my_shero/screens/contacts/addnewcont.dart';
import 'package:my_shero/screens/contacts/contact_screen.dart';
import 'package:my_shero/screens/emergency/govnumbers.dart';
import 'package:my_shero/screens/locations/locations.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/SendSms/sendsms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applicdation.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SafePlacesPage(),
      // home: GovContactsPage(),
      // home: LoginPage(),
      // home: AddContact(),
      home: HomeScreen(),
      // home: SendSms());
    );
  }
}
