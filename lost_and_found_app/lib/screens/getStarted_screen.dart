import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lost_and_found_app/screens/createAccount.dart';

import '../widgets/customButtonIcon.dart';
import '../widgets/customTextEntry.dart';
import '../widgets/lineDivider_widget.dart';
import '../widgets/long_button.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Let's Get Started",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sign up or login to have a full hands-on\nexperience with Find It ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomLongButton(
              text: "Ceate Account",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        CreateAccountScreen(), // Replace 'NextPage' with your actual next page widget
                  ),
                );
              },
              textColor: Colors.white,
              backgroundColor: Color(0xff7e3bc2),
            ),
            const SizedBox(height: 20),
            CustomLongButton(
              text: "Login",
              onPressed: () {},
              textColor: Colors.white,
              backgroundColor: Color(0xff7e3bc2),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: LineDividerWithText(
                text: 'OR',
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                thickness: 1.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            CustomButtonIcon(
              text: 'Continue with Google',
              onPressed: () {},
              iconAssetPath: 'assets/images/google_icon.png',
            ),
            const SizedBox(height: 20),
            CustomButtonIcon(
              text: 'Continue with Facebook',
              onPressed: () {},
              iconAssetPath: 'assets/images/facebook_icon.png',
            ),
          ],
        ),
      ),
    );
  }
}
