import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:drivecoach/screen/view_training_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';


class AddTraining extends StatefulWidget {
  @override
  _AddTrainingState createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  DateTime _date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1990),
        lastDate: DateTime(2023));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        print(_date.toString());
      });
    }
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
  }

  FirebaseAuthenticationController authentiable =
      FirebaseAuthenticationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Training"),
        backgroundColor: Colors.purple,
      ),
      body: addNewTraining(),
    );
  }

  static String currentUserId;

  Future<FirebaseUser> user =
  FirebaseAuth.instance.currentUser().then((onValue) {
    currentUserId = onValue.uid;
    return onValue;
  });


  void addTraining() {
    authentiable.collectionTrainingRefrence.document().setData({
      'title': _titleController.text,
      'about': _aboutController.text,
      'start_date': _date,
      'duration': _durationController.text,
      'price_per_hour': _priceController.text,
      'location' : _locationController.text,
      'user_id': currentUserId
    });
    Fluttertoast.showToast(msg: "The Training Course  is added");
  }

  Widget addNewTraining() {
    return Form(
      key: _formKey,
      child: ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Course Title",

              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Driving Course Title is required';
                } else
                  return null;
              },
            ),


            TextFormField(
              maxLines: 4,
              controller: _aboutController,
              decoration: InputDecoration(
                hintText: "About Course",



              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Driving Course details is required';
                } else
                  return null;
              },
            ),SizedBox(
              height: 40,
            ),

            Row(
              children: <Widget>[
                Text("Start of Course"),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () {
                    selectDate(context);
                  },
                ),
                Text(_date.toString()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 48,
                right: 48,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Course Duration by day",
              ),
              controller: _durationController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Duration is required';
                } else
                  return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Price per hour",
              ),
              keyboardType: TextInputType.number,
              controller: _priceController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Price is required';
                } else
                  return null;
              },
            ),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: "Location",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Location is required';
                } else
                  return null;
              },
            ),
            SizedBox(height: 10,),
            Image.network(""),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.purple,
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                        onPressed: () async {
                          addTraining();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.purple,
                        child: Text(
                          "View Traffic Rules",
                          style: TextStyle(
                              color: Colors.white, fontSize: 16, letterSpacing: 1),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewTrainingList();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
