import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/MyWidgets/custom_text.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

class CreateBtn extends StatefulWidget {
  const CreateBtn({Key? key}) : super(key: key);

  @override
  State<CreateBtn> createState() => _CreateBtnState();
}

class _CreateBtnState extends State<CreateBtn> {
  bool isCreating = false;
  @override
  Widget build(BuildContext context) {
    return isCreating
        ? RefreshProgressIndicator()
        : ElevatedButton(
            onPressed: () {
              //loading on
              setState(() {
                isCreating = true;
              });

              //Send Create Data to Database
              Future.delayed(Duration(milliseconds: 2000)).then((value) {
                setState(() {

                  isCreating = false;
                });
              });
            },
            child: CustomText(
              text: "Create",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            style: ElevatedButton.styleFrom(
                primary: MyColors.ctBtn,
                fixedSize: Size(
                    MyScreenSize.mGetWidth(context: context, percentage: 60),
                    0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          );
  }
}
