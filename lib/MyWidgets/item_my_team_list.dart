import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/MyWidgets/custom_snackbar.dart';
import 'package:hicogoapp/MyWidgets/custom_text.dart';
import 'package:hicogoapp/Services/authentication.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

class MyTeamListItem extends StatelessWidget {
  final String autoTeamId;
  final String teamName;
  final String userRole;
  final String type;
  final String joinStatus;
  const MyTeamListItem(
      {Key? key,
      required this.autoTeamId,
      required this.teamName,
      required this.userRole,
      required this.type,
      required this.joinStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(teamName);
        CustomSnackBar(content: teamName, context: context)
            .showCustomSnackbar();
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Start Part
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "$teamName",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        CustomText(
                          text: "$userRole",
                          fontSize: 14,
                          color: MyColors.deadText,
                        )
                      ],
                    ),
                  ),

                  //End part
                  Container(
                    width: MyScreenSize.mGetWidth(
                        context: context, percentage: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //if team is public
                        if (type == 'public') ...[
                          Icon(
                            Icons.public,
                            size: 20,
                            color: MyColors.deadText,
                          ),
                        ] else ...[
                          Icon(
                            Icons.lock,
                            size: 20,
                            color: MyColors.deadText,
                          ),
                        ],

                        SizedBox(
                          height: 14,
                        ),

                        joinStatus == 'pending'
                            ? CustomText(
                                //if join req in pending..
                                text: "Pending",
                                color: MyColors.pendingText,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              )
                            : CustomText(
                                //if already joined in the team
                                text: "Joined",
                                color: MyColors.ctBtn,
                                fontSize: 14,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: MyColors.deadText, height: 0)
          ],
        ),
      ),
    );
  }
}
