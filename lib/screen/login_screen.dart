import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/authentication/authentiable.dart';
import 'package:drivecoach/screen/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'admin_main_Screen.dart';
import 'trainee_main_screen.dart';
import 'trainer_main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthenticationController authentiable =
      FirebaseAuthenticationController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String type;
  String errorMessage = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                scale: 1.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 48,
                right: 48,
              ),
            ),
            Text(
              "Log in",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.purple,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.purple,
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16, letterSpacing: 1),
                    ),
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      print(email);
                      print(password);
                      try {
                        var user = await authentiable
                            .login(email, password)
                            .then((user_info) {
                          Firestore.instance
                              .collection('users')
                              .where('user_id', isEqualTo: user_info.uid)
                              .snapshots()
                              .listen((data) {
                            type = data.documents.first['user_type'];

                            if (!user_info.uid.isEmpty) {
                              if (type == 'trainee') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TraineeMainScreen();
                                    },
                                  ),
                                );
                              } else if (type == 'trainer') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TrainerMainScreen();
                                    },
                                  ),
                                );
                              }else if (type == 'admin') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AdminMainScreen();
                                    },
                                  ),
                                );
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: " email and password are required");
                            }
                          });
                        });
                      } catch (error) {
                        switch (error.code) {
                          case "ERROR_INVALID_EMAIL":
                            errorMessage =
                                "Your email address appears to be malformed.";
                            break;
                          case "ERROR_WRONG_PASSWORD":
                            errorMessage = "Your password is wrong.";
                            break;
                          case "ERROR_USER_NOT_FOUND":
                            errorMessage =
                                "User with this email doesn't exist.";
                            break;
                          case "ERROR_USER_DISABLED":
                            errorMessage =
                                "User with this email has been disabled.";
                            break;
                          case "ERROR_TOO_MANY_REQUESTS":
                            errorMessage =
                                "Too many requests. Try again later.";
                            break;
                          case "ERROR_OPERATION_NOT_ALLOWED":
                            errorMessage =
                                "Signing in with Email and Password is not enabled.";
                            break;
                          default:
                            errorMessage = "An undefined Error happened.";
                        }

                      }

                      if (errorMessage != null) {
                        Fluttertoast.showToast(
                            msg: errorMessage);
                        return Future.error(errorMessage);
                      }


                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
