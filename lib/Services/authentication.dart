import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hicogoapp/Constants/const.name.dart';

class AuthenticationClass {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    final String accountExisted = "account-exists-with-different-credential";
    final String crendentialInvalid = "invalid-credential";

    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        print("Google Sign in: " + user.toString());

        /* Navigator.of(context).pushReplacement(PageTransition(
            child: TeamCheckScreen(),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 800))); */

      } on FirebaseAuthException catch (e) {
        if (e.code == accountExisted) {
          //handle the error here
          ScaffoldMessenger.of(context).showSnackBar(
              AuthenticationClass.customSnackBar(
                  content:
                      "The account is already exists with a differrent crendential.",
                  bgColor: Colors.red,
                  textColor: Colors.white));
        } else if (e.code == crendentialInvalid) {
          //handle the error here
          ScaffoldMessenger.of(context).showSnackBar(
              AuthenticationClass.customSnackBar(
                  content:
                      "Error occured while accesing credentials. Try again!",
                  bgColor: Colors.red,
                  textColor: Colors.white));
        }
      } catch (e) {
        //handle the error here
        ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationClass.customSnackBar(
                content: "Error occured using Google Sign-In. Try again!",
                bgColor: Colors.red,
                textColor: Colors.white));
      }
    }

    return user;
  }

  //SignUp
  static Future<bool?> _signupUser(String email, String pass) {
    return Future.delayed(Duration(milliseconds: 0)).then((_) async {
      try {
        FirebaseAuth mAuth = FirebaseAuth.instance;
        UserCredential authResult = await mAuth.createUserWithEmailAndPassword(
            email: email, password: pass);
        User? user = authResult.user;
        if (user != null) {
          print(ConstPrintColor.printGreen +
              "Registered Successfull" +
              ConstPrintColor.endColor);
        } else {
          print(ConstPrintColor.printRed +
              "Error in Registraion" +
              ConstPrintColor.endColor);
        }
      } on FirebaseException catch (e) {
        print(
            ConstPrintColor.printRed + e.toString() + ConstPrintColor.endColor);
      }
      return null;
    });
  }
/*  static  _signupUser(String email, String pass) async {
    try {
      FirebaseAuth mAuth = FirebaseAuth.instance;
      UserCredential authResult = await mAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User? user = authResult.user;
      if (user != null) {
        print(ConstPrintColor.printGreen +
            "Registered Successfull" +
            ConstPrintColor.endColor);
        return true;
      } else {
        print(ConstPrintColor.printRed +
            "Error in Registraion" +
            ConstPrintColor.endColor);
        return false;
      }
    } on FirebaseException catch (e) {
      return false;
      print(ConstPrintColor.printRed + e.toString() + ConstPrintColor.endColor);
    }
  } */

//signout
  static mSignOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // on the web platform, you do not need to call the googleSignIn.signOut()
      //so check first
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();

      /* Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen())); */
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          AuthenticationClass.customSnackBar(
              content: "Error signing out. Try again!!",
              bgColor: Colors.red,
              textColor: Colors.white));
    }
  }

  //Auto sign in
  static User? mInitializeFirebaseApp() {
    User? user = FirebaseAuth.instance.currentUser;

    return user;

    // return firebaseApp;
  }

//create a custom snackbar
  static SnackBar customSnackBar(
      {required String content,
      required Color bgColor,
      required Color textColor}) {
    return SnackBar(
      backgroundColor: bgColor,
      content: Text(
        content,
        style: TextStyle(color: textColor, letterSpacing: 0.5),
      ),
    );
  }
}
