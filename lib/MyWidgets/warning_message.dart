import 'package:flutter/material.dart';
import 'package:hicogoapp/main.dart';

class WarningMessageScreen extends StatelessWidget {
  const WarningMessageScreen({Key? key, required this.message})
      : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$message",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              /*  ElevatedButton(
                  onPressed: () => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        ),
                      },
                  child: Text("Back")), */
            ],
          )
        ],
      ),
    );
  }
}
