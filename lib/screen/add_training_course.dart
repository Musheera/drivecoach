import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTraining extends StatefulWidget {
  @override
  _AddTrainingState createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  TextEditingController _carController = TextEditingController();


  @override
  void dispose() {
    _carController.dispose();

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

  void addTraining() {
    authentiable.collectionTrainingRefrence.document().setData(
        {'car_type': _carController.text});
    Fluttertoast.showToast(
        msg:
            "The Training Course is added");
  }

  Widget addNewTraining() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        TextFormField(
          controller: _carController,
          decoration: InputDecoration(
            hintText: "Type of car",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Car type is required';
            }  else
              return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 48,
            right: 48,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Driving License",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Driving License is required';
            } else
              return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Car Form",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Car Form is required';
            } else
              return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "National Identify",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'National Identify is required';
            } else
              return null;
          },
        ), TextFormField(
          decoration: InputDecoration(
            hintText: "IBAN",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'IBAN is required';
            } else
              return null;
          },
        ),
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
                          color: Colors.white, fontSize: 16, letterSpacing: 1),
                    ),
                    onPressed: () async {
                      addTraining();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
