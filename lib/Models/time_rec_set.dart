import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:hicogoapp/Constants/const.name.dart';
import 'package:hicogoapp/Services/services.firestore.dart';
import 'package:hicogoapp/Utils/screen_size.dart';
import 'package:intl/intl.dart';

import 'time_record.dart';

class TimeRecordSet extends StatefulWidget {
  final DateTime selectedDate;
  final BuildContext context;
  final double height;

  TimeRecordSet({
    required this.context,
    required this.selectedDate,
    required this.height,
  });

  @override
  State<TimeRecordSet> createState() => _TimeRecordSetState();
}

class _TimeRecordSetState extends State<TimeRecordSet> {
  int totalHour = 0;
  int totalMinutes = 0;

  @override
  void initState() {
    super.initState();
    print(ConstPrintColor.printRed +
        "time rec initstate().." +
        ConstPrintColor.endColor);
  }

  @override
  Widget build(BuildContext context) {
    print("\x1b[32m Build: Models/time_rec_set_model.dart  \x1b[0m");
    print(
        "${ConstPrintColor.printYellow} SelectedDate:${ConstPrintColor.endColor} ${widget.selectedDate.millisecondsSinceEpoch}");
    _mGetTotalDuration();

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      // height: 50,
      height: widget.height,
      width: MyScreenSize.mGetWidth(context: context, percentage: 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Calander part
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  // height: //MyScreenSize.mGetHeight(context: context, percentage: 10),
                  margin: EdgeInsets.only(
                    top: 8,
                    left: 10,
                    bottom: 0,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(5),
                                  topEnd: Radius.circular(5),
                                  bottomEnd: Radius.elliptical(50, 10),
                                  bottomStart: Radius.elliptical(50, 10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${month(widget.selectedDate)}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16, color: Colors.white,
                                    // fontWeight: FontWeight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(8),
                                  bottomEnd: Radius.circular(8),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${widget.selectedDate.day}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    // fontWeight: FontWeight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Text(
                    "$totalHour h",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text("$totalMinutes m",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          ),

          //time record item part
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(ConstKeys.collRefTimeRecord)
                    .orderBy(ConstKeys.starttime, descending: true)
                    .where(
                      ConstKeys.starttime,
                      isGreaterThanOrEqualTo:
                          widget.selectedDate.millisecondsSinceEpoch,
                      isLessThan: widget.selectedDate
                          .add(Duration(days: 1))
                          .millisecondsSinceEpoch,
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return GFShimmer(child: _mEmptyBlock());
                  }
                  // List<DocumentSnapshot> allDocs = snapshot.data!.docs.toList();
                  final myData = snapshot.requireData;

                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: myData.size,
                      itemBuilder: (context, index) {
                        int timeno = myData.docs[index][ConstKeys.timeno];
                        int elapsedtime =
                            myData.docs[index][ConstKeys.elapsedtime];
                        int empno = myData.docs[index][ConstKeys.empno];
                        /*  int timeno = allDocs[index].data[ConstKeys.timeno];*/
                        int isaccepted =
                            myData.docs[index][ConstKeys.isaccepted];
                        int starttime = myData.docs[index][ConstKeys.starttime];
                        int endtime = myData.docs[index][ConstKeys.endtime];
                        String comment = myData.docs[index][ConstKeys.comment];
                        String userfullname =
                            myData.docs[index][ConstKeys.userfullname];

                        return TimeRecord(
                            timeno: timeno,
                            empno: empno,
                            userfullname: userfullname,
                            starttime: starttime,
                            endtime: endtime,
                            comment: comment,
                            isaccepted: isaccepted,
                            elapsedtime: elapsedtime);
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String month(DateTime dateTime) {
    return DateFormat.MMM().format(dateTime);
  }

  void mCalTotalduration(num totalDuration) {
    int hourMillis = 60 * 60 * 1000;
    var h = (totalDuration / hourMillis);
    totalDuration %= hourMillis;
    int minMillis = 60 * 1000;
    var m = (totalDuration / minMillis);
    totalHour = h.floor();
    totalMinutes = m.floor();
  }

  Widget _mEmptyBlock() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 46,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(widget.context).size.width * 0.5,
                      height: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(widget.context).size.width * 0.25,
                      height: 8,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 46,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(widget.context).size.width * 0.5,
                      height: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(widget.context).size.width * 0.25,
                      height: 8,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _mGetTotalDuration() async {
    await ServicesFirestore.collRefTimeRecord
        .where(
          ConstKeys.starttime,
          isGreaterThanOrEqualTo: widget.selectedDate.millisecondsSinceEpoch,
          isLessThan:
              widget.selectedDate.add(Duration(days: 1)).millisecondsSinceEpoch,
        )
        .snapshots()
        .listen((querySnapshot) {
      num totalDuration = 0;
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        if (querySnapshot.docs[i][ConstKeys.endtime] != -1) {
          totalDuration += (querySnapshot.docs[i][ConstKeys.endtime] -
              querySnapshot.docs[i][ConstKeys.starttime]);
        }
      }
      mCalTotalduration(totalDuration);
    });
  }
}
