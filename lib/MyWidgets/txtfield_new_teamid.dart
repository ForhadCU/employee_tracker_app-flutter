import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';

class NewTeamId extends StatefulWidget {
  const NewTeamId({Key? key}) : super(key: key);

  @override
  _NewTeamIdState createState() => _NewTeamIdState();
}

class _NewTeamIdState extends State<NewTeamId> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          label: Text("New team id"),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.ctBtn, width: 0.0)
          )),

    );
  }
}
