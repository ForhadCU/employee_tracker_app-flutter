import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: "AIzaSyCEsDWkWu8_kTHFo7NRFLgnLVsDW3vfm6U",
        authDomain: "agami-hicogo.firebaseapp.com",
        projectId: "agami-hicogo",
        storageBucket: "agami-hicogo.appspot.com",
        messagingSenderId: "140235667742",
        appId: "1:140235667742:web:50c2c70cc77873adc0b10f",
        measurementId: "G-JT2FZ26RQM",
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: "AIzaSyCEsDWkWu8_kTHFo7NRFLgnLVsDW3vfm6U",
        authDomain: "agami-hicogo.firebaseapp.com",
        projectId: "agami-hicogo",
        storageBucket: "agami-hicogo.appspot.com",
        messagingSenderId: "140235667742",
        appId: "1:140235667742:web:50c2c70cc77873adc0b10f",
        measurementId: "G-JT2FZ26RQM",
        iosBundleId: 'com.agamilabs.hicogo',
        // iosClientId:
        //     '448618578101-ja1be10uicsa2dvss16gh4hkqks0vq61.apps.googleusercontent.com',
        // androidClientId:
            // '448618578101-2baveavh8bvs2famsa5r8t77fe1nrcn6.apps.googleusercontent.com',
        // databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
          apiKey: "AIzaSyCEsDWkWu8_kTHFo7NRFLgnLVsDW3vfm6U",
          authDomain: "agami-hicogo.firebaseapp.com",
          projectId: "agami-hicogo",
          storageBucket: "agami-hicogo.appspot.com",
          messagingSenderId: "140235667742",
          appId: "1:140235667742:web:50c2c70cc77873adc0b10f",
          measurementId: "G-JT2FZ26RQM");
    }
  }
}
