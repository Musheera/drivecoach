import 'package:drivecoach/screen/first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/main_screen.dart';
import 'screen/home_screen.dart';
import 'authentication/authentication_controller.dart';
//import 'package:map_view/map_view.dart';

void main() {
  //MapView.setApiKey("AIzaSyBqTK4Ugc3tzN3M49n1q9qW33U-X8HZhEU");
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
