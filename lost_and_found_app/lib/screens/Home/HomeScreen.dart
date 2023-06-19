import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found_app/authentication/auth.dart';
import 'package:lost_and_found_app/screens/createPost.dart';
import 'package:lost_and_found_app/screens/starting%20screens/getStarted_screen.dart';
import 'package:lost_and_found_app/widgets/long_button.dart';

import '../../models/feed_model.dart';
import '../../models/post_model.dart';
import '../../remote_data_source/firestore_helper.dart';
import '../../widgets/feedWidget.dart';
import '../default_feeds.dart';

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
  List<FeedModel> _feeds = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    loadDefaultFeeds();
  }

  void fetchUserData() async {
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

  void loadDefaultFeeds() {
    // Create and add default feeds
    setState(() {
      _feeds = defaultFeeds;
    });
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
        builder: (context) => CreatePostPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show a loading indicator while fetching the username
      return const Scaffold(
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
      // Display the HomeScreen with the fetched username and feeds
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome $_username",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff7e3bc2),
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
                      _handleCreatePost(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Create Post"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      primary: const Color(0xff7e3bc2),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Create a Post about a missing\nobject you Found on 'Found it'",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<List<PostModel>>(
                  stream: FirestoreHelper.read(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Some error occurred"),
                      );
                    }
                    if (snapshot.hasData) {
                      final postData = snapshot.data;
                      return ListView.builder(
                        itemCount: postData!.length,
                        itemBuilder: (context, index) {
                          final singlePost = postData[index];
                          return FeedWidget(
                            username: _username,
                            foundItem: "${singlePost.itemName}",
                            itemDescription: "${singlePost.description}",
                            imagePath: 'assets/images/passport.jpg',
                            dateTime: "18th June 2023",
                            location: "${singlePost.location}",
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  }
}
