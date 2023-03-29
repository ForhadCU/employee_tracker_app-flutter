import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/* class ExampleWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget>
    with SingleTickerProviderStateMixin {
  static const _animDuration = 3;

  late AnimationController _controller;
  late Map<Type, GestureRecognizerFactory> _customGestures;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    print("Running initState from Animation class");
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: _animDuration),
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: 200).animate(_controller);
    _customGestures = Map<Type, GestureRecognizerFactory>();
    _customGestures[LongPressGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
      () => LongPressGestureRecognizer(
          duration: Duration(seconds: _animDuration), debugOwner: this),
      (LongPressGestureRecognizer instance) {
        instance
          ..onLongPress = () {}
          ..onLongPressStart = (details) {
            _controller.forward();
          }
          ..onLongPressMoveUpdate = (details) {}
          ..onLongPressEnd = (details) {
            //check animation status,
            _controller.reverse();
          }
          ..onLongPressUp = () {};
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: _customGestures,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: Colors.grey,
            style: BorderStyle.solid,
          ),
          color: Colors.white,
        ),
        width: 200,
        height: 50,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: _widthAnimation.value,
                color: Colors.indigo,
              ),
            );
          },
        ),
      ),
    );
  }
} */

class MyAnimationScreen extends StatefulWidget {
  const MyAnimationScreen({Key? key}) : super(key: key);

  @override
  _MyAnimationScreenState createState() => _MyAnimationScreenState();
}

class _MyAnimationScreenState extends State<MyAnimationScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  int count = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween<double>(begin: 40, end: 150).animate(controller)
      ..addListener(() {
        // The state that has changed here is the animation object’s value.
        Future.delayed(Duration(milliseconds: 2000)).then((value) {
          setState(() {
            count++;
          });
        });
      });
    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedLogo(animation: animation);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(8.0),
              height: 150,
              width: 150,
              child: Center(
                child: Text(
                  "$count",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Image.asset(
              "lib/assets/images/play_button.png",
              height: animation.value,
              width: animation.value,
            ),
          ],
        ),
      ),
    );
  }
}

/* class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
} */

