import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.name.dart';
import 'package:hicogoapp/MyWidgets/alert_dlg_join_team.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

import 'alert_dlg_create_team.dart';

class BtnTeam extends StatefulWidget {
  final String btnName;
  final Color color;
  final String id;
  const BtnTeam(
      {Key? key, required this.id, required this.btnName, required this.color})
      : super(key: key);

  @override
  State<BtnTeam> createState() => _BtnTeamState();
}

class _BtnTeamState extends State<BtnTeam> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.id == ConstKeys.joinTeamId
            ? () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return JoinTeamAlertDlg();
                    });
                print("Clicked");
              }
            : () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateTeamAlertDlg();
                    });
              },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(Size(150, 0)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.00),
                    side: BorderSide(color: widget.color)))),
        child: Text(widget.btnName,
            style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.bold,
                fontSize: 18.0)));
  }
}
