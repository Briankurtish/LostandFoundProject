import 'package:flutter/material.dart';

class LineDividerWithText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double thickness;
  final Color color;

  const LineDividerWithText({
    required this.text,
    this.textStyle,
    this.thickness = 1.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
