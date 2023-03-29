import 'package:flutter/material.dart';

class ConstKeys {
  static final String collRefTimeRecord = "TimeRecord";
  static final String collRefNotification = "Notification";
  static final String timeno = "timeno";
  static final String elapsedtime = "elapsedtime";
  static final String empno = "empno";
  static final String isaccepted = "isaccepted";
  static final String starttime = "starttime";
  static final String endtime = "endtime";
  static final String comment = "comment";
  static final String userfullname = "userfullname";

  static final String avatarurl = "avatarurl";
  static final String subtitle = "subtitle";
  static final String desc = "desc";
  static final String noticeid = "noticeid";
  static final String noticeimgurl = "noticeimgurl";
  static final String title = "title";
  static final String userid = "userid";
  static final String uploaddate = "uploaddate";
  static final String status = "status";

  static final String uKeyEmail = "email";
  static final String uKeyName = "name";
  static final String uKeyCreatedDate = "createddate";
  static final String uKeyPass = "password";
  static final String uKeyPhone = "phone";
  static final String uKeyUid = "userid";

  static final String userCollRef = "USERS";
  static final String teamCollRef = "TEAMS";

  static const IconData iconPhone =
      IconData(0xe4a2, fontFamily: 'MaterialIcons');

  static const String joinTeamId = "jt";
  static const String createTeamId = "ct";
}

class ConstUrl {
  static final String testImageUrl =
      "https://bs-uploads.toptal.io/blackfish-uploads/components/blog_post_page/content/cover_image_file/cover_image/688738/cover-0408-FlutterMessangerDemo-Luke_Newsletter-30d5a65064b44f0ef56a801d4811964a.png";
  static final String avatarImageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6rBqACkG_9oUZ2DQ2xkdLsjU04alqi5gzLC9d9MwQ33yYFGCPFJN5YvddijPB7P2VELA&usqp=CAU";
}

class ConstCalculation {
  static final today = DateTime.now();
  static final DateTime firstDayOfLastWeek =
      today.subtract(Duration(days: today.weekday + 7));
}

class ConstPrintColor {
  static final String printBlack = "\x1B[30m";
  static final String printRed = "\x1B[31m";
  static final String printGreen = "\x1B[32m";
  static final String printYellow = "\x1B[33m";
  static final String printBlue = "\x1B[34m";
  static final String printMagenta = "\x1B[35m";
  static final String printCyan = "\x1B[36m";
  static final String printWhite = "\x1B[37m";
  static final String endColor = "\x1B[0m";
}

class ConstErrorMessage {
  static final String usernameField = "*Required username";
  static final String emailField = "*Required email address";
  static final String phoneField = "*Required valid mobile number";
  static final String phoneFieldNumExceeded = "Less than 10 digits";
  static final String phoneFieldWrongDigit = "First digit must be 1";
  static final String passField = "*Requied at least 6 characters";
  static final String confirmPassField = "Password doesn't match";
}
