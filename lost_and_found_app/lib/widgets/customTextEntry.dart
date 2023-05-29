import 'package:flutter/material.dart';

class CustomTextEntry extends StatelessWidget {
  final String placeholder;

  const CustomTextEntry({
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
