import 'package:flutter/material.dart';
import 'package:lost_and_found_app/screens/settings/settingsscreen.dart';

import '../constants/global_variables.dart';
import 'Chat/chatScreen.dart';
import 'Home/HomeScreen.dart';
import 'My Posts/myPostScreen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MyPostScreen(),
    ChatScreen(),
    SettingsScreen(),
    // Add other screen instances here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_board),
            label: 'My Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // Add other BottomNavigationBarItems here
        ],
        selectedItemColor:
            GlobalVariables.mainColor, // Set the active icon color
        unselectedItemColor: Colors.grey, // Set the inactive icon color
      ),
    );
  }
}
