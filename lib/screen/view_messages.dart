import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/screen/update_rules.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewMessageList extends StatefulWidget {
  @override
  _ViewMessageListState createState() => _ViewMessageListState();
}

getMessages() async {
  return await Firestore.instance.collection('message').getDocuments();
}

class _ViewMessageListState extends State<ViewMessageList> {
  QuerySnapshot messageNo;

  @override
  void initState() {
    super.initState();
    getMessages().then((data) {
      setState(() {
        messageNo = data;
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('VIEW MESSAGES'),
          backgroundColor: Colors.purple,
        ),
        body: showMessageList());
  }

  Widget showMessageList() {
    if (messageNo != null && messageNo.documents != null) {
      return ListView.builder(
        itemCount: messageNo.documents.length,
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
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      messageNo.documents[index].reference.delete();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => showMessageList()),
                              (Route<dynamic> route) => false);
                    },
                  ),

                  title: Text('${messageNo.documents[index].data['title']}' ,
                    style: TextStyle(color: Colors.purple,),),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(messageNo.documents[index].data['message']),

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
    } else if (messageNo == null && messageNo.documents.length == 0) {
      return Text(
        "No Message!",
        style: TextStyle(fontSize: 19),
      );
    } else {
      print(messageNo);

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




}