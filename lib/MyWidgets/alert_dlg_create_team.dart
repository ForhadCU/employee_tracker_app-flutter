import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/MyWidgets/btn_create.dart';
import 'package:hicogoapp/MyWidgets/txtfield_new_teamid.dart';
import 'package:hicogoapp/MyWidgets/txtfield_new_teamname.dart';

import 'custom_text.dart';

class CreateTeamAlertDlg extends StatefulWidget {
  const CreateTeamAlertDlg({Key? key}) : super(key: key);

  @override
  _CreateTeamAlertDlgState createState() => _CreateTeamAlertDlgState();
}

class _CreateTeamAlertDlgState extends State<CreateTeamAlertDlg> {
  bool isCreate = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Checking Part
            Column(children: [
              CustomText(
                text: "Create Team",
                color: MyColors.ctBtn,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),

              NewTeamName(), //team name textfield
              SizedBox(
                height: 15,
              ),
              NewTeamId(), //team id textfield
              SizedBox(
                height: 20,
              ),
              //Create Button Part
              CreateBtn(), //create btn

              //team id textfield
            ]),
          ],
        ),
      ),
    );
  }
}
