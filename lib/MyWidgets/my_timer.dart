import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.name.dart';
import 'package:hicogoapp/MyWidgets/play_timer_cir.dart';
import 'package:hicogoapp/MyWidgets/stop_timer_cir.dart';
import 'package:hicogoapp/Services/services.firestore.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({Key? key}) : super(key: key);

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> with TickerProviderStateMixin {
  StopWatchTimer _stopWatchTimer = StopWatchTimer();
  // late AnimationController animationController;

  var isRunning = false;
  var presetHour = 01;
  var presetMin = 45;
  var presetSec = 30;
  var runningDocId;
  var runningStartTime;
  // var mapTimeRecSet;

  @override
  void initState() {
/*     animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: true); */

    super.initState();

    /* Future.delayed(Duration(microseconds: 3000), () {
      print("isRunning is: $isRunning");
    }); */
    ServicesFirestore.collRefTimeRecord
        .where(ConstKeys.endtime, isLessThan: 0)
        .snapshots()
        .listen((querySnapshot) {
      var nullFound;
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        if (querySnapshot.docs[i][ConstKeys.endtime] < 0) {
          nullFound = true;
          runningDocId = querySnapshot.docs[i].id;
          runningStartTime = querySnapshot.docs[i][ConstKeys.starttime];
          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
          // var diffInMillis = DateTime.now()
          //     .difference(DateTime.parse(runningStartTime))
          //     .inSeconds;
          var diffInMillis = DateTime.now()
              .difference(DateTime.fromMillisecondsSinceEpoch(runningStartTime))
              .inSeconds;
          int hourMillis = 60 * 60;
          var h = (diffInMillis / hourMillis);
          diffInMillis %= hourMillis;
          int minMillis = 60;
          var m = (diffInMillis / minMillis);
          var s = diffInMillis %= minMillis;

          _stopWatchTimer.setPresetHoursTime(h.floor());
          _stopWatchTimer.setPresetMinuteTime(m.floor());
          _stopWatchTimer.setPresetSecondTime(s.floor());
          break;
        } else {
          nullFound = false;
          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
        }
      }

      setState(() {
        isRunning = nullFound ?? false;
        // i = querySnapshot.docs.length;
        // print("\n" + i.toString());
      });
    });

/*     if (isRunning) {
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      _stopWatchTimer.setPresetHoursTime(presetHour);
      _stopWatchTimer.setPresetMinuteTime(presetMin);
      _stopWatchTimer.setPresetSecondTime(presetSec);
    } */
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    // animationController.dispose();

    super.dispose();
  }

  playTimerCircleComponets() {
    return Icon(
      Icons.play_arrow,
      color: Colors.white,
      size: 64.0,
    );
  }

  stopTimerCircleComponents() {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            child: Icon(
              Icons.pause,
              size: 24.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          //Applying stopwatch to the UI
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data;
              final displayTime =
                  StopWatchTimer.getDisplayTime(value!, milliSecond: false);
              return Container(
                  child: Text(displayTime,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0)));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("\x1b[32m Build: MyWidgets/my_timer.dart \x1b[0m");

    return Container(
      color: Colors.transparent,
      height: 180, //MyScreenSize.mGetHeight(context: context, percentage: 26),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            // constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
            height: 90,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, 1)
                      .withOpacity(0.3), //Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 0),
                  blurRadius: 0,
                )
              ],
              color: Color(0x00000000), //Color.fromRGBO(186, 216, 206, 1),
              border: Border.all(
                color: Color(0x33000000), //Color.fromRGBO(186, 216, 206, 1),
                width: 0,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.elliptical(900, 500),
              ),
            ),
            // child: Image.asset("lib/assets/images/Images31.png"),
          ),
          Positioned(
            bottom: 36.0,
            child: InkWell(
              borderRadius: BorderRadius.circular(180.0),
              onLongPress: () {},
              onTap: () {
                // _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                setState(() {
                  !isRunning ? _method2() : _method1();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                //   // Provide an optional curve to make the animation feel smoother.
                curve: Curves.fastOutSlowIn,
                // width: widthHeightConstraint,
                // height: widthHeightConstraint,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    !isRunning ? PlayTimerCircle() : StopTimerCircle(),
                    // Positioned(),
                    !isRunning
                        ? playTimerCircleComponets()
                        : stopTimerCircleComponents(),
                    /*     isRunning
                        ? CircularProgressIndicator(
                            value: animationController.value,
                            semanticsLabel: 'Linear progress indicator',
                          )
                        : CircularProgressIndicator(
                            value: animationController.value,
                            semanticsLabel: 'Linear progress indicator',
                          ) */
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _method1() {
    isRunning = false;
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    if (runningDocId != null) {
      ServicesFirestore.collRefTimeRecord.doc(runningDocId).update({
        ConstKeys.endtime: DateTime.now().millisecondsSinceEpoch
      }).whenComplete(() => runningDocId = null);
    }
  }

  _method2() {
    isRunning = true;
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    Map<String, dynamic> mapTimeRecSet = {
      ConstKeys.timeno: 1,
      ConstKeys.elapsedtime: 0,
      ConstKeys.isaccepted: 1,
      ConstKeys.starttime: DateTime.now().millisecondsSinceEpoch,
      ConstKeys.endtime: -1,
      ConstKeys.comment: "",
      ConstKeys.userfullname: "SomeOne",
      ConstKeys.empno: 1,
    };
    addTimeRecord(mapTimeRecSet).whenComplete(() {
      setState(() {
        print("\x1b[33m Current DocId:\x1b[0m $runningDocId");
      });
    });
  }

  Future<void> addTimeRecord(Map<String, dynamic> mapTimeRecSet) async {
    return await ServicesFirestore.collRefTimeRecord
        .add(mapTimeRecSet)
        .then((value) => runningDocId = value.id);
  }
}
