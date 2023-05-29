import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomButtonIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String iconAssetPath;

  const CustomButtonIcon({
    required this.text,
    required this.onPressed,
    required this.iconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          iconAssetPath, // Replace with the path to your Google logo/icon image
          height: 24.0,
          width: 24.0,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
