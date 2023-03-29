import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

import 'custom_text.dart';

class TeamSearchResult extends StatelessWidget {
  const TeamSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 40,
      ),
      CustomText(
        text: "Display Team name",
        color: Colors.black54,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 40,
      ),
      ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: MyColors.jtBtn,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fixedSize: Size(MyScreenSize.mGetWidth(context: context, percentage: 60), 0)
          ),
          child: CustomText(
            text: "Send Join Request",
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
    ]);
  }
}
