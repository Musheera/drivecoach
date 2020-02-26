import 'package:drivecoach/screen/first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/main_screen.dart';
import 'screen/home_screen.dart';
import 'authentication/authentication_controller.dart';

void main() {
  runApp(DriveApp());
}

class DriveApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget logged = MainScreen();
    FirebaseAuthenticationController currentUser =
    FirebaseAuthenticationController();
    print(currentUser.getCurrentUser());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: logged,
    );
  }
}
