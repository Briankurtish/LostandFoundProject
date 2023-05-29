import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/customTextEntry.dart';
import '../widgets/long_button.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
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
                  children: const [
                    Text(
                      "Getting Started!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Looks like you are new to us! Create an\naccount for a complete experience",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50),
                    CustomTextEntry(
                      placeholder: 'Username',
                    ),
                    SizedBox(height: 20.0),
                    CustomTextEntry(
                      placeholder: 'Email',
                    ),
                    SizedBox(height: 20.0),
                    CustomTextEntry(
                      placeholder: 'Phone Number',
                    ),
                    SizedBox(height: 20.0),
                    CustomTextEntry(
                      placeholder: 'Password',
                    ),
                    SizedBox(height: 20.0),
                    CustomTextEntry(
                      placeholder: 'Confirm Password',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: CustomLongButton(
              text: "Next",
              onPressed: () {},
              textColor: Colors.white,
              backgroundColor: Color(0xff7e3bc2),
            ),
          ),
        ],
      ),
    );
  }
}
