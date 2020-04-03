import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new course'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 13),
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                scale: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
