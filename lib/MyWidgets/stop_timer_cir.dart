import 'package:flutter/material.dart';

class StopTimerCircle extends StatelessWidget {
  const StopTimerCircle({Key? key}) : super(key: key);
  Future<double> get _height => Future<double>.value(180);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: ClipOval(
        child: FutureBuilder<double>(
          future: _height,
          initialData: 0.0,
          builder: (context, snapshot) {
            return Image.asset(
              "lib/assets/images/Images31.png",
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
