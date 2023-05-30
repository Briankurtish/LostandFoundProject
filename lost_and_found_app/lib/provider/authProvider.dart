import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  String? _username;

  String? get username => _username;

  Future<void> fetchUsername(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        _username = userDoc.data()!['username'];
      }
    } catch (e) {
      print('Error fetching username: $e');
    }
    notifyListeners();
  }
}
