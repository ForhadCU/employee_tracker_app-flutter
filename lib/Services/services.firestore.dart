import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hicogoapp/Constants/const.name.dart';

class ServicesFirestore {
  static final CollectionReference collRefTimeRecord =
      FirebaseFirestore.instance.collection(ConstKeys.collRefTimeRecord);
  static final CollectionReference collRefNotification =
      FirebaseFirestore.instance.collection(ConstKeys.collRefNotification);
  static final CollectionReference collRefUser = FirebaseFirestore.instance
      .collection(ConstKeys.userCollRef);
  static final CollectionReference collRefTeam = FirebaseFirestore.instance
      .collection(ConstKeys.teamCollRef);
}
