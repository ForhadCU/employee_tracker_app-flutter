import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/Constants/const.name.dart';
import 'package:hicogoapp/Models/my_team.dart';
import 'package:hicogoapp/MyWidgets/alert_dlg_create_team.dart';
import 'package:hicogoapp/MyWidgets/alert_dlg_join_team.dart';
import 'package:hicogoapp/MyWidgets/btn_team.dart';
import 'package:hicogoapp/MyWidgets/custom_text.dart';
import 'package:hicogoapp/MyWidgets/customtoolbarshape.dart';
import 'package:hicogoapp/MyWidgets/item_my_team_list.dart';
import 'package:hicogoapp/Services/get_teamlist.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

class TeamCheckScreen extends StatefulWidget {
  final String uid;
  const TeamCheckScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _TeamCheckScreenState createState() => _TeamCheckScreenState();
}

class _TeamCheckScreenState extends State<TeamCheckScreen>
    with TickerProviderStateMixin {
  bool isListFound = false;
  List<MyTeamModel>? myTeams;
  late bool isListGetting;
  late AnimationController controller;
  String type = "public";
  String joinStatus = "pending";

  @override
  void initState() {
    // TODO: implement initState
    isListGetting = true;

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..addListener(() {
            setState(() {});
          });
    controller.repeat(reverse: true);

    MyTeamListSevice.getMyTeams().then((teams) {
      myTeams = teams;

      //Loading test
      Future.delayed(Duration(milliseconds: 5000))
          .then((value) => isListGetting = false);
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          //Appbar and Buttons Part in 30% of Screen
          Container(
            height: MyScreenSize.mGetHeight(context: context, percentage: 30),
            child: Column(
              children: [
                //Custom Appbar
                Container(
                  color: Colors.transparent,
                  child: CustomToolbarShape.getAppBar(
                    context,
                    110,
                    false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //Join Team and Create Team Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BtnTeam(
                          id: ConstKeys.joinTeamId,
                          btnName: "Join Team",
                          color: MyColors.jtBtn),
                      BtnTeam(
                          id: ConstKeys.createTeamId,
                          btnName: "Create Team",
                          color: MyColors.ctBtn)
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Show Team List Part in 70% of Screen
          Container(
            height: MyScreenSize.mGetHeight(context: context, percentage: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Team list",
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black45,
                  thickness: 1.5,
                  height: 0,
                ),

                //show list here..
                isListGetting
                    ? Expanded(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                strokeWidth: 2,
                                value: controller.value,
                                semanticsLabel: "Searching...",
                                backgroundColor: MyColors.appbarPrimary,
                                color: MyColors.jtBtn,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Please wait for a while...",
                                color: MyColors.deadText,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          )
                        ],
                      ))

                      //Show my team list...
                    : Expanded(
                        child: myTeams!.length > 0
                            ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                itemCount: myTeams!.length,
                                itemBuilder: (context, index) {
                                  MyTeamModel myTeammodel = myTeams![index];

                                  return MyTeamListItem(
                                      autoTeamId:
                                          myTeammodel.autoteamid.toString(),
                                      teamName: myTeammodel.teamname.toString(),
                                      userRole: myTeammodel.userrole.toString(),
                                      type: myTeammodel.type.toString(),
                                      joinStatus:
                                          myTeammodel.joinstatus.toString());
                                })
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: "No Result Found !",
                                        color: MyColors.deadText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.00,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return JoinTeamAlertDlg();
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                            text: "Join Team",
                                            color: Colors.blue,
                                            textDecoration:
                                                TextDecoration.underline,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text: "OR",
                                        color: MyColors.deadText,
                                        fontSize: 16.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext contxt) {
                                                return CreateTeamAlertDlg();
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                            text: "Create Team",
                                            color: Colors.blue,
                                            textDecoration:
                                                TextDecoration.underline,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
