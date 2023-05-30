import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lost_and_found_app/screens/createAccount.dart';
import 'package:lost_and_found_app/widgets/customTextEntry.dart';
import 'package:lost_and_found_app/widgets/long_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

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
                  onPressed: () {},
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
