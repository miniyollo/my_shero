import 'package:flutter/material.dart';
import 'package:my_shero/assets/theme.dart';
import 'package:my_shero/screens/Profile/profilepage.dart';
import 'package:my_shero/screens/SendSms/sendsms.dart';
import 'package:my_shero/screens/locations/locations.dart';
import 'package:shake/shake.dart';

import 'screens/Auth/SignUp.dart';
import 'screens/contacts/addnewcont.dart';
import 'screens/emergency/govnumbers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Default index of first screen

  // List of widgets to call on navigation
  final List<Widget> _widgetOptions = [
    SafePlacesPage(),
    GovContactsPage(),
    ProfilePage(),
    AddContact(),
    SendSms(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the index
    });
  }

@override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }
  


  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Display the selected page
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Gov Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Add Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Add Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppTheme.nearlyDarkRed,
        onTap: _onItemTapped,
      ),
    );
  }
}
