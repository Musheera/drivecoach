import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/screen/view_doc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'admin_main_Screen.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:imagebutton/imagebutton.dart';
import 'view_doc.dart';

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
  QuerySnapshot userNoCopy;
  QuerySnapshot ratingList;

  double rating = 0;
  int starCount = 6;
  bool isSearching = false;
  QuerySnapshot userNoFilter;

  @override
  void initState() {
    super.initState();
    getUsers().then((data) {
      setState(() {
        userNo = userNoFilter = userNoCopy = data;
      });
    });

    getRatingList().then((onValue) {
      setState(() {
        ratingList = onValue;
      });
    });
  }

  filterTrainer(value) async {
    userNoFilter = await Firestore.instance
        .collection('users')
        .where('name', isEqualTo: value)
        .getDocuments();
    setState(() {
      userNo = userNoFilter;
    });
  }

  static String userId;

  Future<FirebaseUser> user =
      FirebaseAuth.instance.currentUser().then((onValue) {
    userId = onValue.uid;
    return onValue;
  });

  getRatingList() async {
    return await Firestore.instance
        .collection('rating')
        .where('rater_id', isEqualTo: userId)
        .getDocuments()
        .then((onValue) {
      return onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? Text('VIEW TRAINERS')
              : TextField(
                  onChanged: (value) {
                    filterTrainer(value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search Trainer",
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            isSearching
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.isSearching = false;
                        userNo = userNoCopy;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = true;
                      });
                    },
                  )
          ],
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
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ViewDoc(
                                            "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                                userNo.documents[index]
                                                    .data['driving_license'] +
                                                '?alt=media',
                                            "DRIVING LICENSE");
                                      },
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
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
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ViewDoc(
                                            "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                                userNo.documents[index]
                                                    .data['car_form'] +
                                                '?alt=media',
                                            "CAR FORM");
                                      },
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
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
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ViewDoc(
                                          "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                              userNo.documents[index]
                                                  .data['national_identify'] +
                                              '?alt=media',
                                          "NATIONAL IDENTIFY");
                                    },
                                  ));
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
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
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ViewDoc(
                                          "https://firebasestorage.googleapis.com/v0/b/drivecoach-d21b9.appspot.com/o/" +
                                              userNo.documents[index]
                                                  .data['iban'] +
                                              '?alt=media',
                                          "IBAN");
                                    },
                                  ));
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
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
                                                  .data['iban'] +
                                              '?alt=media',
                                          fit: BoxFit.fill,
                                          //scale: .50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          viewRating(userNo.documents[index].documentID),
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

  Widget viewRating(String documentID) {
    int index;
    List<String> id = List<String>();
    for (int i = 0; i < ratingList.documents.length; i++) {
      if (documentID == ratingList.documents[i].data['rated_id']) {
        id.add(documentID);

          index = i;

      }
    }

    print('size ${id.length}');
    if (!id.contains(documentID))
      return Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: new StarRating(
              size: 20.0,
              rating: rating,
              color: Colors.orange,
              borderColor: Colors.grey,
              starCount: starCount,
              onRatingChanged: (rating) => setState(() {
                Firestore.instance.collection('rating').document().setData({
                  'rater_id': userId,
                  'rated_id': documentID,
                  'stars': rating
                });
                id.add(documentID);
                this.rating = rating;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewTrainerList(),
                    ));

              }),
            ),
          ),
          new Text(
            "$rating",
          ),
        ],
      );
    else{
      id.clear();
      return Column(children: <Widget>[
      Text("Rated: ${ratingList.documents[index].data['stars']}")
    ]);}
  }
}
