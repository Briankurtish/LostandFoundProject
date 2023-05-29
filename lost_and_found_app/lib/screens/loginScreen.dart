import 'package:flutter/material.dart';
import 'package:lost_and_found_app/screens/createAccount.dart';
import 'package:lost_and_found_app/widgets/customTextEntry.dart';
import 'package:lost_and_found_app/widgets/long_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    const CustomTextEntry(
                      placeholder: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 20.0),
                    const CustomTextEntry(
                      placeholder: 'Password',
                      icon: Icons.fingerprint,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          " Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7e3bc2),
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
                padding: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                child: CustomLongButton(
                  text: "Login",
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
