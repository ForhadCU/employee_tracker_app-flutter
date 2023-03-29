import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hicogoapp/Constants/const.name.dart';
import 'package:hicogoapp/Models/update_time_rec_set.dart';
import 'package:hicogoapp/MyWidgets/customtoolbarshape.dart';
import 'package:hicogoapp/MyWidgets/my_timer.dart';
import 'package:hicogoapp/Services/services.firestore.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

void main() {
  runApp(MaterialApp(
    home: DashboardScreeen(),
  ));
}

class DashboardScreeen extends StatefulWidget {
  const DashboardScreeen({Key? key}) : super(key: key);

  @override
  _DashboardScreeenState createState() => _DashboardScreeenState();
}

class _DashboardScreeenState extends State<DashboardScreeen> {
  late var currentDate = DateTime.now();
  late DatePickerController _datePickerController;
  late List<DateTime> selectedDateList;
  int totalHour = 0;
  int totalMinutes = 0;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    print(ConstPrintColor.printYellow +
        "Dashboard initState() running.." +
        ConstPrintColor.endColor);
    _datePickerController = DatePickerController();
    selectedDateList = [];
    var today = DateTime.now();
    selectedDateList.add(DateTime(today.year, today.month, today.day));

    Future.delayed(Duration(seconds: 5)).then((value) {
      _datePickerController.animateToSelection(
        duration: Duration(seconds: 3),
        curve: Curves.fastOutSlowIn,
      );
    });
    ServicesFirestore.collRefNotification.snapshots().listen((docSnapshot) {
      counter = 0;
      for (var i = 0; i < docSnapshot.docs.length; i++) {
        if (docSnapshot.docs[i][ConstKeys.status] == "unread") {
          counter++;
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print("\x1b[32m Build: DashboardScreen() \x1b[0m");
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              color: Colors.transparent,
              child: CustomToolbarShape.getAppBar(
                context,
                150,
                // MyScreenSize.mGetHeight(context: context, percentage: 22),
                true,
                username: "S.h. Mazumder",
                photourl:
                    "https://karostartup.com/uploads/company_post/91524.png",
                photoweight: 0.60,
                badgeCounter: counter,
              ),
            ),
          ),

          //Time record Part
          Positioned(
            top: 220,
            child: Container(
              width: MyScreenSize.mGetWidth(
                context: context,
                percentage: 100,
              ),
              height: MyScreenSize.mGetHeight(
                    context: context,
                    percentage: 100,
                  ) -
                  230,
              child: ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount: selectedDateList.length,
                itemBuilder: (bcontext, index) {
                  double h_ratio = selectedDateList.length < 2 ? 0.7 : 0.5;
                  return TimeRecSetModel.TimeRecordSet(
                      context: context,
                      selectedDate: selectedDateList[index],
                      height: MyScreenSize.mGetHeight(
                              context: context, percentage: 100) *
                          h_ratio);

                  /* TimeRecordSet(
                    context: bcontext,
                    selectedDate: selectedDateList[index],
                    height: MyScreenSize.mGetHeight(
                            context: context, percentage: 100) *
                        h_ratio,
                  ); */
                },
              ),
            ),
          ),

          Positioned(
            top: 160,
            child: Visibility(
              visible: true,
              child: Container(
                height: 80,
                color: Colors.white,
                width: MyScreenSize.mGetWidth(
                  context: context,
                  percentage: 100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 6,
                          child: DatePicker(
                            DateTime.now().subtract(const Duration(days: 30)),
                            controller: _datePickerController,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: Colors.black,
                            selectedTextColor: Colors.white,
                            inactiveDates: [
                              DateTime.now().add(const Duration(days: 1))
                            ],
                            daysCount: 32,
                            onDateChange: (date) {
                              // _datePickerController.animateToSelection(
                              //   duration: Duration(seconds: 1),
                              // );
                              // New date selected
                              setState(() {
                                // _selectedValue = date;
                                selectedDateList.clear();
                                selectedDateList.add(date);
                              });
                            },
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.double_arrow_outlined,
                                  size: 32,
                                ),
                                onPressed: () {
                                  _showCalender(context: context);
                                },
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          //Timer Part
          Positioned(
            bottom: 0,
            child: MyTimer(),
          ),
        ],
      ),
    );
  }

  //Methods..

  _thisWeekDateList() {
    selectedDateList.clear();
    DateTime dateCount;
    for (var i = currentDate.weekday; i > 0; i--) {
      dateCount =
          currentDate.subtract(new Duration(days: currentDate.weekday - i));
      selectedDateList.add(dateCount);
    }
  }

  _lastWeekDateList() {
    selectedDateList.clear();
    DateTime dateCount;
    for (var i = 0; i < 7; i++) {
      dateCount =
          currentDate.subtract(new Duration(days: currentDate.weekday + i));
      selectedDateList.add(dateCount);
    }
  }

  _thisMonthDateList() {
    selectedDateList.clear();
    DateTime dateCount;
    var monthday = DateTime.now().day;

    for (var i = 0; i < monthday; i++) {
      dateCount = currentDate.subtract(new Duration(days: i));
      selectedDateList.add(dateCount);
    }
  }

  _lastMonthDateList() {
    selectedDateList.clear();
    DateTime dateCount;
    var monthday = DateTime.now().day;
    int year = DateTime.now().year;
    int month1 = DateTime.now().month;
    DateTime thisMonth = DateTime(year, month1, 0);
    DateTime lastMonth = DateTime(year, month1 - 1, 0);
    int lastMonthdays = thisMonth.difference(lastMonth).inDays;

    for (var i = 0; i < lastMonthdays; i++) {
      dateCount = currentDate.subtract(new Duration(days: monthday + i));
      selectedDateList.add(dateCount);
    }
  }

  _showCalender({required BuildContext context}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 15,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                height:
                    MyScreenSize.mGetHeight(context: context, percentage: 20),
                width: MyScreenSize.mGetWidth(context: context, percentage: 80),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GFButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _thisWeekDateList();
                              });
                            },
                            text: "This Week",
                            type: GFButtonType.outline2x,
                          ),
                          GFButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _lastWeekDateList();
                              });
                            },
                            text: "Last Week",
                            type: GFButtonType.outline2x,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GFButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _thisMonthDateList();
                              });
                            },
                            text: "This Month",
                            type: GFButtonType.outline2x,
                          ),
                          GFButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _lastMonthDateList();
                              });
                            },
                            text: "Last Month",
                            type: GFButtonType.outline2x,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
