import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blueAccent;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(size.width * 1.0, size.height * 0.0);
    path.quadraticBezierTo(size.width * 1.0, size.height * 0.1,
        size.width * 0.1, size.height * 0.1);

    // path.lineTo(size.width, size.height * 0.1);
    // path.quadraticBezierTo(
    //     size.width * 0.0, size.height * 0.11, 0, size.height * 0.16);

    // path.lineTo(0, size.height * 0.25);
    // path.quadraticBezierTo(size.width * 0.001, size.height * 0.18,
    //     size.width * 0.0, size.height * 0.19);

    // path.lineTo(size.width * 0.8, size.height * 0.29);
    // path.quadraticBezierTo(
    //     size.width * 0.99, size.height * 0.29, size.width, size.height * 0.19);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// The {CustomContainerShapeBorder} should be reactibe with different sizes,
/// If it isn't then chamge the offset values.
class CustomContainerShapeBorder extends CustomPainter {
  final double height;
  final double width;
  final Color fillColor;
  final double radius;

  CustomContainerShapeBorder({
    this.height: 400.0,
    this.width: 300.0,
    this.fillColor: Colors.white,
    this.radius: 50.0,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    path.moveTo(0.0, -radius);
    path.lineTo(0.0, -(height - radius));
    path.conicTo(0.0, -height, radius, -height, 1);
    path.lineTo(width - radius, -height);
    path.conicTo(width, -height, width, -(height + radius), 1);
    path.lineTo(width, -(height - radius));
    path.lineTo(width, -radius);

    path.conicTo(width, 0.0, width - radius, 0.0, 1);
    path.lineTo(radius, 0.0);
    path.conicTo(0.0, 0.0, 0.0, -radius, 1);
    path.close();
    canvas.drawPath(path, Paint()..color = fillColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
