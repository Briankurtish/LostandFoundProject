import 'package:flutter/material.dart';

class CustomTextEntry extends StatefulWidget {
  final String placeholder;
  final IconData icon;

  const CustomTextEntry({
    required this.placeholder,
    required this.icon,
  });

  @override
  State<CustomTextEntry> createState() => _CustomTextEntryState();
}

class _CustomTextEntryState extends State<CustomTextEntry> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: Color(0xff7e3bc2),
          ),
          hintText: widget.placeholder,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }
}
