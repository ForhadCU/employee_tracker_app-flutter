import 'package:flutter/material.dart';
import 'package:hicogoapp/MyWidgets/circle_bar.dart';

class LongPressAnimScreen extends StatefulWidget {
  @override
  _LongPressAnimScreenState createState() => _LongPressAnimScreenState();
}

class _LongPressAnimScreenState extends State<LongPressAnimScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  bool showFingerPrint = false;
  bool isAnimationCompleted = false;
  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            break;
          case AnimationStatus.completed:
            isAnimationCompleted = true;
            _controller.reverse();
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.dismissed:
            if (isAnimationCompleted) {
              setState(() {
                showFingerPrint = !showFingerPrint;
              });
              isAnimationCompleted = false;
            }
            break;
        }
      });
  }

  _onLongPressStart(LongPressStartDetails details) {
    if (!_controller.isAnimating) {
      _controller.forward();
    } else {
      _controller.forward(from: _controller.value);
    }
  }

  _onLongPressEnd(LongPressEndDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[50],
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onLongPressStart: _onLongPressStart,
              onLongPressEnd: _onLongPressEnd,
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.scale(
                      scale: ((_controller.value * 0.2) + 1),
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.all(10),
                        height: 100,
                        child: Stack(
                          children: <Widget>[
                            CircularProgres(value: _controller.value),
                            Container(
                              child: showFingerPrint
                                  ? Center(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.blue[900],
                                        size: 50,
                                      ),
                                    )
                                  : FingerPrintIcon(value: _controller.value),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue[100] as Color,
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: Offset(16, 16)),
                          ],
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class FingerPrintIcon extends StatelessWidget {
  final double value;
  FingerPrintIcon({required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Icon(
            Icons.fingerprint,
            color: Colors.blue,
            size: 50,
          ),
        ),
        Positioned(
          bottom: 15,
          child: ClipRect(
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: value,
              child: Icon(
                Icons.fingerprint,
                color: Colors.blue[900],
                size: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
