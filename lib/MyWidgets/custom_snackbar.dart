
import 'package:flutter/material.dart';

class CustomSnackBar {
  final BuildContext context;
  final String content;
  final Color? textColor;
  final Color? bgColor;

  const CustomSnackBar(
      {required this.context,
      required this.content,
      this.textColor,
      this.bgColor});

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showCustomSnackbar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: TextStyle(color: textColor, letterSpacing: 0.5),
        ),
        backgroundColor: bgColor,
      ),
    );
  }

  /* SnackBar(
      content: Text(
        content,
        style: TextStyle(
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
      backgroundColor: bgColor,
    ); */

}
