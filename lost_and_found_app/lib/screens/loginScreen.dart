import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/authentication/auth.dart';
import 'package:lost_and_found_app/screens/HomeScreen.dart';
import 'package:lost_and_found_app/screens/createAccount.dart';
import 'package:lost_and_found_app/screens/forgotPassword.dart';
import 'package:lost_and_found_app/widgets/customTextEntry.dart';
import 'package:lost_and_found_app/widgets/long_button.dart';
import 'package:lost_and_found_app/widgets/passwordEntry.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

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
                      "Welcome Back!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome again. Enter your credentials to login",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    CustomTextEntry(
                      placeholder: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 20.0),
                    PasswordTextEntry(
                      placeholder: 'Password',
                      icon: Icons.fingerprint,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ForgotPasswordScreen(), // Replace 'NextPage' with your actual next page widget
                              ),
                            );
                          },
                          child: const Text(
                            " Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7e3bc2),
                            ),
                          ),
                        ),
                      ],
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
                  const Text("Don't Have an Account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CreateAccountScreen(), // Replace 'NextPage' with your actual next page widget
                        ),
                      );
                    },
                    child: const Text(
                      "  Sign Up!",
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
                  onPressed: isLoading ? null : _loginUser,
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Color(
                          0xff7e3bc2) // Customize the button's background color
                      ),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Color(0xff7e3bc2),
                          strokeWidth: 5,
                        )
                      : Text(
                          'Login',
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

  void _loginUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text;

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        // User logged in successfully, navigate to the next screen or perform any other actions
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                HomeScreen(), // Replace 'NextPage' with your actual next page widget
          ),
        );
      } else {
        _showErrorMessage('Failed to log in. Please try again.');
      }
    } catch (e) {
      print('Error logging in: $e');
      _showErrorMessage(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
