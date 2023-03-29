import 'package:flutter/material.dart';
import 'package:hicogoapp/Constants/const.color.dart';
import 'package:hicogoapp/Models/my_team.dart';
import 'package:hicogoapp/MyWidgets/item_my_team_list.dart';
import 'package:hicogoapp/MyWidgets/item_searched_team_rslt.dart';
import 'package:hicogoapp/Services/get_teamlist.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

import 'custom_text.dart';

class CheckTeamAndGetResult extends StatefulWidget {
  const CheckTeamAndGetResult({Key? key}) : super(key: key);

  @override
  State<CheckTeamAndGetResult> createState() => _CheckTeamAndGetResultState();
}

class _CheckTeamAndGetResultState extends State<CheckTeamAndGetResult> {
  bool isChecking = false;
  bool isNotFoundVisible = false;
  bool isDisplayNameVisible = false;
  List<MyTeamModel>? _searchResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Check Team btn
        Container(
          child: Column(
            children: [
              isChecking
                  ? RefreshProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        //User accesses into TEAM collection
                        //Check Whether team exist or not in TEAMS collection
                        setState(() {
                          isChecking = true;
                        });
                        Future.delayed(Duration(milliseconds: 2000))
                            .then((value) {
                          setState(() {
                            isChecking = false;
                          });
                          _searchResults = [];
                          MyTeamListSevice.getSearchTeams().then((teams) {
                            setState(() {
                              _searchResults = teams;

                              //When team found
                              isDisplayNameVisible = true;

                              //When no team found
                              // isNotFoundVisible = true;
                            });
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(

                          elevation: 1,
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: MyColors.jtBtn)),
                          fixedSize: Size(
                              MyScreenSize.mGetWidth(
                                  context: context, percentage: 30),
                              3)),
                      child: Text(
                        "Check",
                        style: TextStyle(
                            color: MyColors.jtBtn,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),

        //Team not found View
        Visibility(
          visible: isNotFoundVisible,
          child: Container(
            child: Column(
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
            ),
          ),
        ),

        //Display Team name and Send Join Req View
        Visibility(
          visible: isDisplayNameVisible,
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Search results",
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
              Divider(
                color: MyColors.deadText,
                thickness: 1,
                height: 5,
              ),

              //Search Team Results...
              Container(
                height:
                    MyScreenSize.mGetHeight(context: context, percentage: 30),
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                    itemCount:
                        _searchResults == null ? 0 : _searchResults!.length,
                        physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final MyTeamModel searchTeam = _searchResults![index];

                      return SearchTeamRsltListItem(
                          autoTeamId: searchTeam.autoteamid.toString(),
                          teamName: searchTeam.teamname.toString(),
                          userRole: searchTeam.userrole.toString(),
                          type: searchTeam.type.toString(),
                          joinStatus: searchTeam.joinstatus.toString());
                    }),
              ),
              SizedBox(
                height: 20,
              ),

              //Send join Req button...
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: MyColors.jtBtn,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: Size(
                          MyScreenSize.mGetWidth(
                              context: context, percentage: 60),
                          0)),
                  child: CustomText(
                    text: "Send Join Request",
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
        )
        //Display Team Name and Send Join req Mod
      ],
    );
  }
}
