import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';

class NewTeamName extends StatefulWidget {
  const NewTeamName({Key? key}) : super(key: key);

  @override
  _NewTeamNameState createState() => _NewTeamNameState();
}

class _NewTeamNameState extends State<NewTeamName> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        label: Text("New team name"),
        border: OutlineInputBorder(borderSide: BorderSide(color: MyColors.ctBtn))
      ),
    );
  }
}
