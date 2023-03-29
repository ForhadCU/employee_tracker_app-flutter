import 'package:flutter/material.dart';

class PlayTimerCircle extends StatelessWidget {
  const PlayTimerCircle({Key? key}) : super(key: key);
  Future<double> get _height => Future<double>.value(100);

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
              "lib/assets/images/play_button.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
