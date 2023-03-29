import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/MyWidgets/check_team_get_result.dart';
import 'package:hicogoapp/MyWidgets/custom_text.dart';

import 'package:hicogoapp/MyWidgets/txtfield_search_team.dart';

class JoinTeamAlertDlg extends StatefulWidget {
  const JoinTeamAlertDlg({Key? key}) : super(key: key);

  @override
  State<JoinTeamAlertDlg> createState() => _JoinTeamAlertDlgState();
}

class _JoinTeamAlertDlgState extends State<JoinTeamAlertDlg> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //Checking Part
              Column(children: [
                CustomText(
                  text: "Join Team",
                  color: MyColors.jtBtn,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 20,
                ),
                SearchTeam(), //textfield for team search
                SizedBox(
                  height: 10,
                ),
                CheckTeamAndGetResult(), //Check btn
              ]),

            ],
          ),
        ),
      ),
    );
  }
}
