import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_main_Screen.dart';

class ViewUserList extends StatefulWidget {
  @override
  _ViewUserListState createState() => _ViewUserListState();
}

getUsers() async {
  return await Firestore.instance.collection('users').getDocuments();
}

class _ViewUserListState extends State<ViewUserList> {
  QuerySnapshot userNo;

  @override
  void initState() {
    super.initState();
    getUsers().then((data) {
      setState(() {
        userNo = data;
      });
    });
  }

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
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      userNo.documents[index].reference.delete();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ViewUserList()),
                              (Route<dynamic> route) => false);
                    },
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
                  title: Text('${userNo.documents[index].data['name']}'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${userNo.documents[index].data['phone']}'),
                      typeType(userNo.documents[index].data['user_type']),
                    ],),
                ),
                Divider(
                  color: Colors.black,
                )
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
      return Row(children: <Widget>[
        Icon(Icons.settings, color: Colors.purple,),
        Text("Admin")
      ],);
    }
    else if (type == 'trainee') {
      return Row(children: <Widget>[
        Icon(Icons.person, color: Colors.purple,),
        Text("Trainee")
      ],);
    }
    else {
      return Row(children: <Widget>[
        Icon(Icons.person, color: Colors.purple,),
        Text("Trainer")
      ],);
    }
  }
}