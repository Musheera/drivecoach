import 'package:drivecoach/User/trainee_model.dart';
import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/screen/first_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drivecoach/screen/trainee_main_screen.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';

class TraineeRegister extends StatefulWidget {
  @override
  _TraineeRegisterState createState() => _TraineeRegisterState();
}

class _TraineeRegisterState extends State<TraineeRegister> {
  ProgressDialog pr;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthenticationController authentiable =
      FirebaseAuthenticationController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final databaseReference = Firestore.instance;
  TraineeModel traineeModel;
  final _formKey = GlobalKey<FormState>();
  String get userImage => null;
  String  fileName ;
  File _img;
  String userimage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _img = image;
    });
  }


  String selectedGender = "";
  String email;
  String password;
  String name;
  String phone;
  String gender;
  String groupValue = 'female';
  String birthday;
  String photo;
  String userId;

  String dropval = 'Female';
  Country _selected;

  void dropChange(String val) {
    setState(() {
      dropval = val;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 24, right: 24, top: 13),
          child: ListView(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xf0595290),
                        child: ClipOval(
                            child: SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_img != null)
                                  ? Image.file(
                                _img,
                                fit: BoxFit.fill,
                              )
                                  : Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/ali_2020_04_01.jpg',
                                                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Full name",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Full name is required';
                  } else
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Email is required';
                  } else
                    return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Password is required';
                  } else
                    return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Phone number",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Phone number is required';
                  } else
                    return null;
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Female",
                        textAlign: TextAlign.start,
                      ),
                      trailing: Radio(
                        value: 'female',
                        groupValue: groupValue,
                        onChanged: (e) => valueChanged(e),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Male",
                        textAlign: TextAlign.start,
                      ),
                      trailing: Radio(
                        value: 'male',
                        groupValue: groupValue,
                        onChanged: (e) => valueChanged(e),
                      ),
                    ),
                  )
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
                        "REGISTER",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      onPressed: () async {
                        validateForm();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getUserPass() {
    email = _emailController.text;
    password = _passwordController.text;
  }

  void getTraineeData() {
    name = _nameController.text;
    phone = _phoneController.text;
  }

  valueChanged(e) {
    setState(() {
      if (e == 'female') {
        groupValue = e;
      } else if (e == 'male') {
        groupValue = e;
      }
    });
  }

  void validateForm() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      getUserPass();

      FirebaseUser firebaseUser = await firebaseAuth.currentUser();

      if (password.length < 8) {
        Fluttertoast.showToast(
            msg: "The password has to be greater than 8 characteristics");
      }
      firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((onValue) {
        authentiable.login(email, password);
        userId = onValue.user.uid;
        uploadPic(context);

      });
    }
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
      authentiable.collectionRefrence.document(userId).setData({
        'name': _nameController.text,
        'country': 'author',
        'phone': _phoneController.text,
        'gender': 'author',
        'photo': 'author',
        'user_type': 'trainee',
        'user_id': userId,
        'user_image': fileName
      });



      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Profile Picture uploaded! "),
      ));
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      var name = _nameController.text;
      Fluttertoast.showToast(msg: "Welcome $name");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TraineeMainScreen();
          },
        ),
      );
    });
  }


}
