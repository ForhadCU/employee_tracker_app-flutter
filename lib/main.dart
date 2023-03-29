import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hicogoapp/Screens/login.dart';

import 'Screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  print("\x1B[36mThis is called from : main()\x1B[0m");
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyNotificationScreen(),
      // home: DashboardScreeen(),
      home: LoginScreen(),
      // home: MyAnimationScreen(),
      // home: ExampleWidget(),
      // home: LongPressAnimScreen(),
    ),
  );
}
