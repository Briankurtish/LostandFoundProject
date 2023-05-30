import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/authentication/messages.dart';
import 'package:lost_and_found_app/provider/authProvider.dart';
import 'package:lost_and_found_app/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

class Auth {
  // creating new instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
    BuildContext context,
    String username,
    String email,
    String phoneNumber,
    String password,
  ) async {
    try {
      // Step 1: Create the user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      // Step 2: Store additional user information in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
      });

      // Step 3: Fetch and store the username from Firestore
      await Provider.of<AuthProvider>(context, listen: false)
          .fetchUsername(user!.uid);

      // Registration successful
      print('User registered successfully!');
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );
      } else {
        print('Failed to log in. Please try again.');
      }
    } catch (e) {
      // Handle any errors that occurred during registration
      print('User registration error: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in the user with email and password
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Access the signed-in user details
      final User? user = userCredential.user;
      const SnackBarPage();

      // Display success message or navigate to the next screen
    } catch (e) {
      // Handle any errors that occur during login
      print('Error logging in: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
