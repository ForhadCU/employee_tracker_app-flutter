import 'package:hicogoapp/Models/my_team.dart';

class MyTeamListSevice {
  static Future<List<MyTeamModel>> getMyTeams() async {
    try {
      final List<MyTeamModel> myTeams = mGetDummyTeams();
      return myTeams;
    } catch (e) {
      final List<MyTeamModel> myTeams = [];
      return myTeams;
    }
  }

  static Future<List<MyTeamModel>> getSearchTeams() async {
    try {
      final List<MyTeamModel> searchTeams = mGetDummySearchRslt();

      return searchTeams;
    } catch (e) {
      final List<MyTeamModel> searchTeams = [];
      return searchTeams;
    }
  }

  static List<MyTeamModel> mGetDummyTeams() {
    final List<MyTeamModel> dummyTeams = [];
    MyTeamModel myTeamModel;

    for (var i = 0; i < 15; i++) {
      myTeamModel = MyTeamModel(
          autoteamid: i.toString(),
          teamname: "My Team $i",
          userrole: i % 2 == 0
              ? "Member"

                  : "Admin",
          joinstatus: i % 2 == 0
              ? "pending"

                  : "joined",
          type: i % 2 == 0 ? "private" : "public");

      dummyTeams.add(myTeamModel);
    }
    return dummyTeams;
  }

  static List<MyTeamModel> mGetDummySearchRslt() {
    final List<MyTeamModel> dummySearchRslt = [];
    MyTeamModel myTeamModel;

    for (var i = 0; i < 15; i++) {
      myTeamModel = MyTeamModel(
          autoteamid: i.toString(),
          teamname: "My Team $i",
          userrole: i % 5 == 0
              ? " "
              : i % 2 == 0
                  ? "Member"
                  : "Admin",
          joinstatus: i % 5 == 0
              ? "no"
              : i % 2 == 0
                  ? "pending"
                  : "joined",
          type: i % 2 == 0 ? "private" : "public");

      dummySearchRslt.add(myTeamModel);
    }
    return dummySearchRslt;
  }
}
