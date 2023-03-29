import 'package:hicogoapp/Models/time_record.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppConnector {
  late List<TimeRecord> mTimeRecord;

  final moviesRef = FirebaseFirestore.instance
      .collection('users/{}/timerecord')
      .withConverter<TimeRecord>(
        fromFirestore: (snapshots, _) => TimeRecord.fromJson(snapshots.data()!),
        toFirestore: (timeRecord, _) => timeRecord.toJson(),
      );

  AppConnector();
}
