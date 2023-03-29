import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/MyWidgets/custom_text.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

class SearchTeamRsltListItem extends StatelessWidget {
  final String autoTeamId;
  final String teamName;
  final String userRole;
  final String type;
  final String joinStatus;
  const SearchTeamRsltListItem(
      {Key? key,
      required this.autoTeamId,
      required this.teamName,
      required this.userRole,
      required this.type,
      required this.joinStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: "$userRole",
                        fontSize: 12,
                        color: MyColors.deadText,
                      )
                    ],
                  ),
                ),

                //End part
                Container(
                  width:
                      MyScreenSize.mGetWidth(context: context, percentage: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //if team is public
                      if (type == 'public') ...[
                        Icon(
                          Icons.public,
                          size: 16,
                          color: MyColors.deadText,
                        ),
                      ] else ...[
                        Icon(
                          Icons.lock,
                          size: 16,
                          color: MyColors.deadText,
                        ),
                      ],

                      SizedBox(
                        height: 8,
                      ),

                      joinStatus == 'pending'
                          ? CustomText(
                              //if join req in pending..
                              text: "Pending",
                              color: MyColors.pendingText,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            )
                          : joinStatus == 'no'
                              ? CustomText(
                                  //if already joined in the team
                                  text: "Not joined",
                                  color: MyColors.jtBtn,
                                  fontSize: 12,
                                )
                              : CustomText(
                                  //if already joined in the team
                                  text: "Joined",
                                  color: MyColors.ctBtn,
                                  fontSize: 12,
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
    );
  }
}
