
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:drivecoach/authentication/authentication_controller.dart';
import 'package:drivecoach/authentication/firebase_auth.dart';
import 'package:drivecoach/main.dart';
import 'package:drivecoach/screen/view_traffic_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'add_training_course.dart';
import 'login_screen.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as Path;

import 'main_screen.dart';

class TrainerMainScreen extends StatefulWidget {
  @override
  _TrainerMainScreenState createState() => _TrainerMainScreenState();
}

class _TrainerMainScreenState extends State<TrainerMainScreen> {
  @override
  //State class
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  String fileName;
  File _img;
  FirebaseAuthenticationController authentiable =
  FirebaseAuthenticationController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
  }
  String userName;
  String userPhone;
  String userEmail;
  String userId;
  String userImage;

  Future<String> getUsernfo() async {
    String uid = await authentiable.getCurrentUser();
    Future<FirebaseUser> user =
    FirebaseAuth.instance.currentUser().then((onValue) {
      userEmail = onValue.email;
      return onValue;
    });
    Firestore.instance
        .collection('users')
        .where('user_id', isEqualTo: uid)
        .snapshots()
        .listen((data) {
      userName = data.documents.first['name'];
      userPhone = data.documents.first['phone'];
      userId = data.documents.first['user_id'];
      userImage = data.documents.first['user_image'];
    });

    print (userImage);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery).then((File image) {
      setState(() {
        _img = image;
      });
    });
  }



  //String get userImage => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        color: Colors.purple,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: ListView(children: <Widget>[
              Column(
                children: <Widget>[
                  Container(child: viewBody(_page)),
                ],
              ),
            ])),
      ),
    );
  }

  Widget viewBody(int index) {
    if (index == 0) {
      return viewHome();
    } else if (index == 1) {
      getUsernfo();
      return viewProfile();
    } else {}

    final CurvedNavigationBarState navBarState =
        _bottomNavigationKey.currentState;
    print("navbar $navBarState");
    navBarState.setPage(index);
  }

  Widget viewHome() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(children: <Widget>[
        IconButton(
          padding: EdgeInsets.only(left: 250),
          icon: Icon(Icons.exit_to_app),
          iconSize: 40,
          alignment: AlignmentDirectional.topEnd,
          color: Colors.purple,
          disabledColor: Colors.purple,
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.push(context,  MaterialPageRoute(builder: (context) { return MainScreen(); },),);
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          iconSize: 50,
          color: Colors.purple,
          disabledColor: Colors.purple,
          onPressed: () {
            Navigator.push(context,  MaterialPageRoute(builder: (context) { return AddTraining(); },),);

          },
        ),
        Text("ADD New Training"),
        SizedBox(
          width: double.infinity,
          height: 50,
        ),
        IconButton(
          icon: Icon(Icons.traffic),
          iconSize: 50,
          color: Colors.purple,
          disabledColor: Colors.purple,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ViewRuleUsersList();
                },
              ),
            );
          },
        ),
        Text("TRAFIC RULES"),
        SizedBox(
          width: double.infinity,
          height: 50,
        ),
        IconButton(
          icon: Icon(Icons.people),
          iconSize: 50,
          color: Colors.purple,
          disabledColor: Colors.purple,
          onPressed: () {},
        ),
        Text("BOOKING"),
        SizedBox(
          width: double.infinity,
          height: 50,
        ),
      ]),
    );
  }

  Widget viewProfile() {
    return Builder(
      builder: (context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
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
                            child:Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/"+userImage+'?alt=media',
                              fit: BoxFit.cover, scale: 0.50,
                            )

                        )),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("UserName",
                              style: TextStyle(
                                  color: Colors.purple, fontSize: 18.0)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(userName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.pen),
                        color: Color(0xff476cfb),
                        onPressed: () {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("New Name"),
                                  content: TextFormField(
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
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text("Update"),
                                      onPressed: () {
                                        setState(() {
                                          userName = _nameController.text;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("PhoneNumber",
                              style: TextStyle(
                                  color: Colors.purple, fontSize: 18.0)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(userPhone,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.pen),
                        color: Color(0xff476cfb),
                        onPressed: () {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("New Phone"),
                                  content: TextFormField(
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
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text("Update"),
                                      onPressed: () {
                                        setState(() {
                                          userPhone = _phoneController.text;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(userEmail,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.purple,
                  onPressed: () {
                    //Navigator.of(context).pop();
                  },
                  elevation: 4.0,
                  splashColor: Colors.purple,
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                RaisedButton(
                  color: Colors.purple,
                  onPressed: () {
                    //uploadPic(context);
                    updateUserInfo();
                  },
                  elevation: 4.0,
                  splashColor: Colors.purple,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateUserInfo() async {
    userName = _nameController.text;
    userPhone = (_phoneController.text!= '')? _phoneController.text : userPhone;

    Firestore.instance.collection('users').document(userId).updateData(
        {'name': userName, 'phone': userPhone});

    print(userName);
    print(userPhone);

  }


}
