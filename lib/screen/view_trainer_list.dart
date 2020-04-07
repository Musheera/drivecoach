import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'admin_main_Screen.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:zoomable_image/zoomable_image.dart';


class ViewTrainerList extends StatefulWidget {
  @override
  _ViewTrainerListState createState() => _ViewTrainerListState();
}

getUsers() async {
  return await Firestore.instance
      .collection('users')
      .where('user_type', isEqualTo: 'trainer')
      .getDocuments();
}

class _ViewTrainerListState extends State<ViewTrainerList> {
  QuerySnapshot userNo;

  double rating = 1;
  int starCount = 6;

  @override
  void initState() {
    super.initState();
    getUsers().then((data) {
      setState(() {
        userNo = data;
      });
    });
  }

  static String userId;

  Future<FirebaseUser> user =
      FirebaseAuth.instance.currentUser().then((onValue) {
    userId = onValue.uid;
    return onValue;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MANAGE USERS'),
          backgroundColor: Colors.purple,
        ),
        body: showUserList());
  }

  Widget showUserList() {
    if (userNo != null && userNo.documents != null) {
      return ListView.builder(
        itemCount: userNo.documents.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      trailing: RaisedButton(
                          color: Colors.purple,
                          child: Text(
                            "Rate",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      contentPadding: EdgeInsets.all(0.0),
                                      title: Text("Rating"),
                                      content: Column(
                                        children: <Widget>[
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                            ),
                                            child: new StarRating(
                                              size: 20.0,
                                              rating: rating,
                                              color: Colors.orange,
                                              borderColor: Colors.grey,
                                              starCount: starCount,
                                              onRatingChanged: (rating) =>
                                                  setState(
                                                () {
                                                 this.rating = rating;
                                                },
                                              ),
                                            ),
                                          ),
                                          new Text(
                                            "$rating",
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        RaisedButton(
                                          child: Text("Rate"),
                                          onPressed: () {
                                            Firestore.instance
                                                .collection('rating')
                                                .document()
                                                .setData({
                                              'rater_id': userId,
                                              'rated_id': userNo
                                                  .documents[index]
                                                  .documentID,
                                              'stars': rating
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
                                    ),
                                  );
                                });
                          }),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Color(0xf0595290),
                          child: ClipOval(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                    userNo.documents[index].data['user_image'] +
                                    '?alt=media',
                                fit: BoxFit.fill,
                                //scale: .50,
                              ),
                            ),
                          ),
                        ),
                      ),

//                  leading: IconButton(
//                    icon: Icon(
//                      Icons.edit,
//                      color: Colors.purple,
//                    ),
//                    onPressed: () {
//                      updateUser(userNo.documents[index].reference.documentID);
//                    },
//                  ),
                      title: Row(children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.amberAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${userNo.documents[index].data['name']}')
                      ]),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('${userNo.documents[index].data['phone']}'),
                            ],
                          ),
                          Divider(
                            color: Colors.red,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Color(0xf0595290),
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: Image.network(
                                        "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                            userNo.documents[index]
                                                .data['driving_license'] +
                                            '?alt=media',
                                        fit: BoxFit.fill,
                                        //scale: .50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Color(0xf0595290),
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: Image.network(
                                        "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                            userNo.documents[index]
                                                .data['car_form'] +
                                            '?alt=media',
                                        fit: BoxFit.fill,
                                        //scale: .50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Color(0xf0595290),
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: Image.network(
                                        "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                            userNo.documents[index]
                                                .data['national_identify'] +
                                            '?alt=media',
                                        fit: BoxFit.fill,
                                        //scale: .50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Color(0xf0595290),
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: Image.network(
                                        "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                            userNo
                                                .documents[index].data['iban'] +
                                            '?alt=media',
                                        fit: BoxFit.fill,
                                        //scale: .50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      );
    } else if (userNo != null && userNo.documents.length == 0) {
      return Text(
        "No Users!",
        style: TextStyle(fontSize: 19),
      );
    } else {
      print(userNo);

      return Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text(
              "Please Wait while load data!",
              style: TextStyle(fontSize: 19),
            )
          ],
        ),
      );
    }
  }

  void updateUser(String documentID) {}

  Widget typeType(String type) {
    if (type == 'admin') {
      return Row(
        children: <Widget>[
          Icon(
            Icons.settings,
            color: Colors.purple,
          ),
          Text("Admin")
        ],
      );
    } else if (type == 'trainee') {
      return Row(
        children: <Widget>[
          Icon(
            Icons.person,
            color: Colors.purple,
          ),
          Text("Trainee")
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Icon(
            Icons.person,
            color: Colors.purple,
          ),
          Text("Trainer")
        ],
      );
    }
  }
}
