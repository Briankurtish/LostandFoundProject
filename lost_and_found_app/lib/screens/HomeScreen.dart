import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found_app/authentication/auth.dart';
import 'package:lost_and_found_app/screens/createPost.dart';
import 'package:lost_and_found_app/screens/getStarted_screen.dart';
import 'package:lost_and_found_app/widgets/long_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Auth _auth = Auth();
  late String _username;
  bool _isLoading = true; // Track the loading state
  String _errorMessage = ''; // Track any error message

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  void fetchUsername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          _username = snapshot.get('username');
          _isLoading = false; // Loading complete
        });
      } else {
        setState(() {
          _isLoading = false; // Loading complete (no user authenticated)
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Loading complete (error occurred)
        _errorMessage = 'Error fetching username';
      });
    }
  }

  void _handleLogout(BuildContext context) async {
    await _auth.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GetStartedScreen(),
      ),
    );
  }

  void _handleCreatePost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePostScreen(username: _username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show a loading indicator while fetching the username
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_errorMessage.isNotEmpty) {
      // Show an error message if there was an error fetching the username
      return Scaffold(
        body: Center(
          child: Text(_errorMessage),
        ),
      );
    } else {
      // Display the HomeScreen with the fetched username
      return Scaffold(
          body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome $_username',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff7e3bc2),
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      _handleLogout(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Create Post"),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      primary: Color(0xff7e3bc2),

                      //backgroundColor: Color(0xff7e3bc2)
                      // Customize the button's background color
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Create a Post about a missing\nobject you Found on 'Found it'",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
        ),
      ));
    }
  }
}
