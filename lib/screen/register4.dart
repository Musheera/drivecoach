import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:drivecoach/screen/register5.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';

class Register4 extends StatefulWidget {
  String userId;
  String email;
  String password;


  Register4(this.userId, this.email, this.password);

  @override
  _Register4State createState() => _Register4State();
}

class _Register4State extends State<Register4> {

  ProgressDialog pr;
  FirebaseAuthenticationController authentiable = FirebaseAuthenticationController();
  String fileName;
  File _img;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _img = image;
    });
  }


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("National Identify"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 150,),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 19, left: 30),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "Upload National Identify",
                  ),
                ),
              ),
              SizedBox(width: 30),
              IconButton(
                icon: Icon(
                  Icons.credit_card,
                  size: 30.0,
                ),
                onPressed: () {
                  getImage();
                },
              ),

            ],
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
                    "NEXT >",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 1),
                  ),
                  onPressed: () async {
                    uploadPic(context);
                    //authentiable.login(email, password);

                  },
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }


  Future uploadPic(BuildContext context) async {
    pr.show();
    fileName = Path.basename(_img.path);

    StorageReference firebaseStorageRefrences =
    FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask storageUploadTask =
    firebaseStorageRefrences.putFile(_img);
    StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
    setState(() {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      updateReg(widget.userId, {'national_identify': fileName});
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Register5(widget.userId, widget.email, widget.password),
          ));
    });}

  void updateReg(String Id, data) async {
    Firestore.instance.collection('users')
        .document(Id)
        .updateData(data);

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("National Identify Picture has uploaded! "),
    ));

  }
}



