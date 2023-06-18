import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/widgets/customTextEntry.dart';

import 'package:lost_and_found_app/widgets/long_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      // You can show a success message to the user or navigate to a confirmation screen
    } catch (e) {
      // Handle any errors that occur during the password reset process
      print('Error sending password reset email: $e');
      // You can show an error message to the user or handle the error in any desired way
    }
  }

  void handleSendPasswordReset() {
    String email = emailController.text
        .trim(); // Get the entered email from the text field

    resetPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Forgot Password!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Enter your email and a verification link will be\nsent to you so as to reset your password.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    CustomTextEntry(
                      placeholder: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    SizedBox(height: 100.0),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                child: CustomLongButton(
                  text: "Send",
                  onPressed: handleSendPasswordReset,
                  textColor: Colors.white,
                  backgroundColor: Color(0xff7e3bc2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
