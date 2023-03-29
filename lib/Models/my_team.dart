class MyTeamModel {
  String? autoteamid;
  String? status;
  String? teamname;
  String? type;
  String? userteamid;
  String? userrole;
  String? joinstatus;

  MyTeamModel(
      {
      this.autoteamid,
      this.status,
      this.teamname,
      this.type,
      this.userteamid,
      this.userrole,
      this.joinstatus});

  MyTeamModel.fromJson(Map<String, dynamic> json) {
    autoteamid = json['autoteamid'];
    status = json['status'];
    teamname = json['teamname'];
    type = json['type'];
    userteamid = json['userteamid'];
    userrole = json['role'];
    joinstatus = json['joinstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autoteamid'] = this.autoteamid;
    data['status'] = this.status;
    data['teamname'] = this.teamname;
    data['type'] = this.type;
    data['userteamid'] = this.userteamid;
    data['role'] = this.userrole;
    data['joinstatus'] = this.joinstatus;
    return data;
  }
}
