import 'package:flutter/material.dart';

import 'custom_text.dart';

class TeamNotFound extends StatelessWidget {
  const TeamNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        CustomText(
          text: "Team Not Found !",
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
