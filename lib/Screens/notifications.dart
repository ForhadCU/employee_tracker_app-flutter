import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.name.dart';
import 'package:hicogoapp/Models/notification.dart';
import 'package:hicogoapp/MyWidgets/customtoolbarshape.dart';
import 'package:hicogoapp/Services/services.firestore.dart';
import 'package:hicogoapp/Utils/screen_size.dart';
import 'package:getwidget/getwidget.dart';

class MyNotificationScreen extends StatefulWidget {
  @override
  _MyNotificationScreenState createState() => _MyNotificationScreenState();
}

class _MyNotificationScreenState extends State<MyNotificationScreen> {
  double height = 160;
  var _chatScrollController;
  int noticeNum = 10; // at first it will load only 10
  // int a = 2; // 'loadMoreMsgs' will added by 'a' if we load more msgs in listview.

  @override
  void initState() {
    super.initState();
    print(ConstPrintColor.printYellow +
        "Notification initState() running.." +
        ConstPrintColor.endColor);

    _chatScrollController = ScrollController()
      ..addListener(() {
        if (_chatScrollController.position.atEdge) {
          if (_chatScrollController.position.pixels == 0)
            print('ListView scrolled to top');
          else {
            setState(() {
              noticeNum = noticeNum + 10;
            });
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    print("\x1b[32m Build: Screens/notifications.dart \x1b[0m");

    return WillPopScope(
      onWillPop: () async {
        // if (_showDialog)
        Navigator.pop(context);
        // Navigator.of(context).pushReplacement(newRoute)
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                color: Colors.transparent,
                child: CustomToolbarShape.getAppBar(
                  context,
                  100,
                  // MyScreenSize.mGetHeight(context: context, percentage: 22),
                  false,
                  username: "S.h. Mazumder",
                  photourl:
                      "https://karostartup.com/uploads/company_post/91524.png",
                  photoweight: 0.60,
                ),
              ),
            ),
            Positioned(
                top: 100,
                child: Container(
                  width: MyScreenSize.mGetWidth(
                    context: context,
                    percentage: 100,
                  ),
                  height: MyScreenSize.mGetHeight(
                        context: context,
                        percentage: 100,
                      ) -
                      100,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(ConstKeys.collRefNotification)
                          .orderBy(ConstKeys.uploaddate, descending: true)
                          .limit(noticeNum)
                          .snapshots(),
                      builder: (BuildContext bcontext,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return GFShimmer(child: _mEmptyBlock());
                        }
                        final myData = snapshot.requireData;

                        return ListView.builder(
                          controller: _chatScrollController,
                          shrinkWrap: false,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: myData.size,
                          itemBuilder: (bcontext, index) {
                            // double h_ratio = selectedDateList.length < 2 ? 0.7 : 0.5;
                            String avatarurl =
                                myData.docs[index][ConstKeys.avatarurl];
                            String desc = myData.docs[index][ConstKeys.desc];
                            String title = myData.docs[index][ConstKeys.title];
                            int userid = myData.docs[index][ConstKeys.userid];
                            int noticeid =
                                myData.docs[index][ConstKeys.noticeid];
                            String noticeimgurl =
                                myData.docs[index][ConstKeys.noticeimgurl];
                            String status =
                                myData.docs[index][ConstKeys.status];

                            print("before $title is $status");

                            status == 'unread'
                                ? _mUpdateStatus(myData.docs[index].id)
                                : null;

                            print("after $title is $status");

                            return NotificationModel(
                              avatarurl: avatarurl,
                              desc: desc,
                              title: title,
                              userid: userid,
                              noticeid: noticeid,
                              noticeimgurl: noticeimgurl,
                              subtitle: "subtitle",
                              status: status,
                            );
                          },
                        );
                      }),
                )

                /*   */
                ),
          ],
        ),
      ),
    );
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
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
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
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
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

  void _mUpdateStatus(String id) {
    ServicesFirestore.collRefNotification
        .doc(id)
        .update({ConstKeys.status: "read"});
  }
}
