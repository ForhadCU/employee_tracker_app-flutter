import 'package:flutter/cupertino.dart';

class MyScreenSize {
  static mGetHeight(
      {required BuildContext context, required double percentage}) {
    return ((MediaQuery.of(context).size.height) * percentage) / 100;
  }

  static mGetWidth(
      {required BuildContext context, required double percentage}) {
    return ((MediaQuery.of(context).size.width) * percentage) / 100;
  }
}
