import 'package:flutter/material.dart';

import 'package:hicogoapp/Screens/notifications.dart';

class CustomToolbarShape extends CustomPainter {
  final Color lineColor;


  const CustomToolbarShape({required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

//First oval
    Path path = Path();
    Rect pathGradientRect = new Rect.fromCircle(
      center: new Offset(size.width / 4, 0),
      radius: size.width / 1.4,
    );

    Gradient gradient = new LinearGradient(
      colors: <Color>[
        Color.fromRGBO(225, 89, 89, 1).withOpacity(1),
        Color.fromRGBO(255, 128, 16, 1).withOpacity(1),
      ],
      stops: [
        0.3,
        1.0,
      ],
    );

    path.lineTo(-size.width / 1.4, 0);
    path.quadraticBezierTo(
        size.width / 2, size.height * 2, size.width + size.width / 1.4, 0);

    paint.color = Colors.deepOrange;
    paint.shader = gradient.createShader(pathGradientRect);
    paint.strokeWidth = 40;
    path.close();

    canvas.drawPath(path, paint);

//Second oval
    Rect secondOvalRect = new Rect.fromPoints(
      Offset(-size.width / 2.5, -size.height),
      Offset(size.width * 1.4, size.height / 1.5),
    );

    gradient = new LinearGradient(
      colors: <Color>[
        Color.fromRGBO(225, 255, 255, 1).withOpacity(0.1),
        Color.fromRGBO(255, 206, 31, 1).withOpacity(0.2),
      ],
      stops: [
        0.0,
        1.0,
      ],
    );
    Paint secondOvalPaint = Paint()
      ..color = Colors.deepOrange
      ..shader = gradient.createShader(secondOvalRect);

    canvas.drawOval(secondOvalRect, secondOvalPaint);

//Third oval
    Rect thirdOvalRect = new Rect.fromPoints(
      Offset(-size.width / 2.5, -size.height),
      Offset(size.width * 1.4, size.height / 2.7),
    );

    gradient = new LinearGradient(
      colors: <Color>[
        Color.fromRGBO(225, 255, 255, 1).withOpacity(0.05),
        Color.fromRGBO(255, 196, 21, 1).withOpacity(0.2),
      ],
      stops: [
        0.0,
        1.0,
      ],
    );
    Paint thirdOvalPaint = Paint()
      ..color = Colors.deepOrange
      ..shader = gradient.createShader(thirdOvalRect);

    canvas.drawOval(thirdOvalRect, thirdOvalPaint);

//Fourth oval
    Rect fourthOvalRect = new Rect.fromPoints(
      Offset(-size.width / 2.4, -size.width / 1.875),
      Offset(size.width / 1.34, size.height / 1.14),
    );

    gradient = new LinearGradient(
      colors: <Color>[
        Colors.red.withOpacity(0.9),
        Color.fromRGBO(255, 128, 16, 1).withOpacity(0.3),
      ],
      stops: [
        0.3,
        1.0,
      ],
    );
    Paint fourthOvalPaint = Paint()
      ..color = Colors.deepOrange
      ..shader = gradient.createShader(fourthOvalRect);

    canvas.drawOval(fourthOvalRect, fourthOvalPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  //
  static Widget getAppBar(BuildContext context, double height, bool advanced,
      {String? username, String? photourl, double? photoweight = 0.5, var badgeCounter}) {
    // final int badgeCounter = 2;
    var photo;
    double widthHeightConstraint = height * (photoweight ?? 0.5);
    if (advanced) {
      if ((photourl ?? "").length > 0) {
        photo = ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.network(
            photourl ?? "",
            height: widthHeightConstraint,
            width: widthHeightConstraint,
          ),
        );
        // photo = Image(
        //   image: new NetworkImage(
        //     photourl,
        //     scale: 1,
        //   ),
        // );
      } else {
        photo = Icon(
          FontAwesomeIcons.userAlt,
          size: 50,
        );
      }

      return Container(
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: height,
              child: CustomPaint(
                painter: CustomToolbarShape(lineColor: Colors.deepOrange),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: ShakeAnimatedWidget(
                enabled: badgeCounter > 0 ? true : false,
                duration: Duration(milliseconds: 2000),
                shakeAngle: Rotation.deg(z: 15),
                curve: Curves.easeInExpo,
                child: GFIconBadge(
                  position: GFBadgePosition.topEnd(end: 0, top: 0),
                  child: GFIconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return MyNotificationScreen();
                      })));
                    },
                    icon: Icon(
                      Icons.notifications,
                    ),
                    shape: GFIconButtonShape.standard,
                    type: GFButtonType.transparent,
                    iconSize: GFSize.MEDIUM,
                  ),
                  counterChild: GFBadge(
                    shape: GFBadgeShape.circle,
                    child: Text("$badgeCounter"),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                // top: 100,
                child: AnimatedContainer(
                  // Define how long the animation should take.
                  duration: const Duration(seconds: 1),
                  //   // Provide an optional curve to make the animation feel smoother.
                  curve: Curves.fastOutSlowIn,
                  width: widthHeightConstraint,
                  height: widthHeightConstraint,
                  //MediaQuery.of(context).size.height / 14.5,
                  padding: EdgeInsets.all(3),
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                        // shadow
                        spreadRadius: .5,
                        // set effect of extending the shadow
                        offset: Offset(
                          0.0,
                          5.0,
                        ),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: photo,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: height,
        child: CustomPaint(
          painter: CustomToolbarShape(lineColor: Colors.green),
          // painter: CustomToolbarShape(lineColor: Colors.deepOrange),
        ),
      );
    }
  }
}


