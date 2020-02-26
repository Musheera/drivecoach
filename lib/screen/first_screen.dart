import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  FirebaseAuthenticationController firebaseAuth =
      FirebaseAuthenticationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("first page"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          color: Colors.purple,
          child: Text(
            "LOGOUT",
            style:
                TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1),
          ),
          onPressed: () async {
            try {
              await firebaseAuth.logout();
            } catch (e) {
              print(e);
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    firebaseAuth.getCurrentUser();
  }
}
