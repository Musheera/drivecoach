import 'package:drivecoach/screen/home_screen.dart';
import 'package:drivecoach/screen/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pageModel.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          scale: 1.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 48, right: 48, bottom: 10),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.purple,
                child: Text(
                  "GET STARTED TO FIND A DRIVER COACH",
                  style: TextStyle(
                      color: Colors.white, fontSize: 13, letterSpacing: 1),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),

      ],
    );
  }
}
