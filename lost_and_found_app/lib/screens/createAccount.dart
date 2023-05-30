import 'package:flutter/material.dart';
import 'package:lost_and_found_app/authentication/auth.dart';

import 'package:lost_and_found_app/screens/loginScreen.dart';

import 'package:lost_and_found_app/widgets/customTextEntry.dart';

import 'package:lost_and_found_app/widgets/long_button.dart';
import 'package:lost_and_found_app/widgets/passwordEntry.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _handleCreateAccount() async {
    setState(() {
      _isLoading = true;
    });

    String username = usernameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passwordController.text;

    // Register the user with Firebase
    await Auth().registerWithEmailAndPassword(
        context, username, email, phone, password);

    setState(() {
      _isLoading = false;
    });
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
                      "Getting Started!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Looks like you are new to us! Create an\naccount for a complete experience",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    CustomTextEntry(
                      placeholder: 'Username',
                      icon: Icons.supervised_user_circle,
                      controller: usernameController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextEntry(
                      placeholder: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextEntry(
                      placeholder: 'Phone Number',
                      icon: Icons.phone,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 20.0),
                    PasswordTextEntry(
                      placeholder: 'Password',
                      icon: Icons.lock,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20.0),
                    PasswordTextEntry(
                      placeholder: 'Confirm Password',
                      icon: Icons.lock,
                      controller: confirmPasswordController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "  Login!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7e3bc2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleCreateAccount,
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Color(
                          0xff7e3bc2) // Customize the button's background color
                      ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Color(0xff7e3bc2),
                          strokeWidth: 5,
                        )
                      : Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .white, // Customize the button's text color
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
