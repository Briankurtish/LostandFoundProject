import 'package:flutter/material.dart';

import '../../authentication/auth.dart';
import '../../widgets/long_button.dart';
import '../starting screens/getStarted_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Auth _auth = Auth();

  void _handleLogout(BuildContext context) async {
    await _auth.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GetStartedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomLongButton(
          text: "Logout",
          onPressed: () {
            _handleLogout(context);
          },
        ),
      ),
    );
  }
}
