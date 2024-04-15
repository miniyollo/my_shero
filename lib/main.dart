
import 'package:flutter/material.dart';



import 'homepage.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
 
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
