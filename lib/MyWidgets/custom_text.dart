import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;

  const CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.fontStyle,
      this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          decoration: textDecoration),
    );
  }
}
