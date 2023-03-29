import 'package:flutter/material.dart';
import 'package:hicogoapp/Utils/screen_size.dart';
import 'package:intl/intl.dart';

class TimeRecord extends StatelessWidget {
  late int timeno;
  late int empno;
  late String userfullname;
  late int starttime;
  late int endtime;
  late String comment;
  late int isaccepted;
  late int elapsedtime;

  TimeRecord({
    required this.timeno,
    required this.empno,
    required this.userfullname,
    required this.starttime,
    required this.endtime,
    required this.comment,
    required this.isaccepted,
    required this.elapsedtime,
  });

  TimeRecord.fromJson(Map<String, dynamic> json) {
    timeno = json['timeno'];
    empno = json['empno'];
    userfullname = json['userfullname'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    comment = json['comment'];
    isaccepted = json['isaccepted'];
    elapsedtime = json['elapsedtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeno'] = this.timeno;
    data['empno'] = this.empno;
    data['userfullname'] = this.userfullname;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['comment'] = this.comment;
    data['isaccepted'] = this.isaccepted;
    data['elapsedtime'] = this.elapsedtime;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    print("\x1b[32m Build: Models/time_record_model.dart  \x1b[0m");

    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: 5,
          bottom: 0,
          left: 5,
          right: 5,
        ),
        /*  width: double
            .infinity, */ //MyScreenSize.mGetWidth(context: context, percentage: 75),
        height: MyScreenSize.mGetHeight(context: context, percentage: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                //width: double
                //  .infinity,
                // width: MyScreenSize.mGetWidth(context: context, percentage: 23),
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Color(0xffA9A9A9),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        showParsedTime(
                          DateTime.fromMillisecondsSinceEpoch(this.starttime),
                        ),
                        //parseTime(this.starttime),
                      ),
                    ],
                  ),
                )),
            Expanded(
              //width: double
              //  .infinity,
              // width: MyScreenSize.mGetWidth(context: context, percentage: 23),
              flex: 1,
              child: this.endtime >= 0
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Color(0xffA9A9A9),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            showParsedTime(
                              DateTime.fromMillisecondsSinceEpoch(this.endtime),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 2),
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  blurRadius: 1,
                                ),
                              ],
                              color: Color.fromRGBO(243, 102, 59, 1),
                              borderRadius: BorderRadius.all(
                                Radius.elliptical(14, 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Positioned(
                            child: Text("IN"),
                          )
                        ],
                      ),
                    ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Color.fromRGBO(186, 216, 206, 1),
                ),
                // width: MyScreenSize.mGetWidth(context: context, percentage: 26),

                //width: double.infinity, //MyScreenSize.mGetWidth(
                //   context: context,
                //   percentage: 27,
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        Icons.timer,
                        color: Color(0xff999999),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    this.endtime < 0
                        ? Text("In Office"
                            // showParsedTime(
                            //   DateTime.fromMillisecondsSinceEpoch(starttime),
                            // ),
                            //formatTIme(this.starttime, outputFormat: "H:i:s"),
                            )
                        : Text(
                            //this.starttime.toString() + this.endtime.toString()
                            formattedElapseTime(
                                DateTime.fromMillisecondsSinceEpoch(
                                        this.starttime)
                                    .toString(),
                                DateTime.fromMillisecondsSinceEpoch(
                                        this.endtime)
                                    .toString(),
                                outputFormat: "H:i:s"),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // static int daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  // static int hoursBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  // static int minutesBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  static String showParsedTime(DateTime _dt) {
    return DateFormat("hh:mm a").format(_dt);
  }

  static String parseTime(String _dt) {
    DateTime? dt = DateTime.parse(_dt);
    /* _dt = dt.hour.toString() +
        "H:" +
        dt.minute.toString() +
        "m:" +
        dt.second.toString() +
        "s"; */

    return DateFormat("hh:mm a").format(dt);
  }

  static String formatTIme(
    String _from, {
    outputFormat: "H:i:s",
  }) {
    DateTime from = DateTime.parse(_from);

    List<dynamic> output = [];

    List<String> format = outputFormat.split(':');

    int diffInMillis = from.millisecond;

    if (format.contains("d")) {
      int dayMillis = 24 * 60 * 60 * 1000;
      String v = (diffInMillis ~/ dayMillis).toString() + "D";
      output.add(v);
      diffInMillis %= dayMillis;
    }

    if (format.contains("H")) {
      int hourMillis = 60 * 60 * 1000;
      String v = (diffInMillis ~/ hourMillis).toString() + "H";
      output.add(v);
      diffInMillis %= hourMillis;
    }

    if (format.contains("i")) {
      int minuteMillis = 60 * 1000;
      String v = (diffInMillis ~/ minuteMillis).toString() + "m";
      output.add(v);
      diffInMillis %= minuteMillis;
    }

    if (format.contains("s")) {
      int milliMillis = 1000;
      String v = (diffInMillis ~/ milliMillis).toString() + "s";
      output.add(v);
      diffInMillis %= milliMillis;
    }

    return output.join(":");
  }

  static String formattedElapseTime(
    String _from,
    String _to, {
    outputFormat: "H:i:s",
  }) {
    // from = DateTime(from.year, from.month, from.day);
    // to = DateTime(to.year, to.month, to.day);
    DateTime from = DateTime.parse(_from);
    DateTime to = DateTime.parse(_to);

    List<dynamic> output = [];

    List<String> format = outputFormat.split(':');

    int diffInMillis = to.difference(from).inMilliseconds;

    if (format.contains("d")) {
      int dayMillis = 24 * 60 * 60 * 1000;
      String v = (diffInMillis ~/ dayMillis).toString() + "D";
      output.add(v);
      diffInMillis %= dayMillis;
    }

    if (format.contains("H")) {
      int hourMillis = 60 * 60 * 1000;
      String v = (diffInMillis ~/ hourMillis).toString() + "H";
      output.add(v);
      diffInMillis %= hourMillis;
    }

    if (format.contains("i")) {
      int minuteMillis = 60 * 1000;
      String v = (diffInMillis ~/ minuteMillis).toString() + "m";
      output.add(v);
      diffInMillis %= minuteMillis;
    }

    if (format.contains("s")) {
      int milliMillis = 1000;
      String v = (diffInMillis ~/ milliMillis).toString() + "s";
      output.add(v);
      diffInMillis %= milliMillis;
    }

    return output.join(":");
  }
}
