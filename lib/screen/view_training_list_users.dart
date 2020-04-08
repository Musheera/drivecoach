import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_map_location_picker/generated/i18n.dart';
import 'admin_main_Screen.dart';
import 'credit_card.dart';

class ViewTrainingListUsers extends StatefulWidget {
  @override
  _ViewTrainingListUsersState createState() => _ViewTrainingListUsersState();
}

class _ViewTrainingListUsersState extends State<ViewTrainingListUsers> {
  QuerySnapshot trainingNo;
  QuerySnapshot payList;
  List <DocumentSnapshot> newResult;
  getTrainings() async {

    return await Firestore.instance.collection('training').getDocuments();
  }

  getPayList() async {
    return await  Firestore.instance.collection('payment').where(
        'trainee_id', isEqualTo: userId).getDocuments().then((onValue) {
      return onValue;
    });
  }

  void initState() {
    super.initState();
    getTrainings().then((onValue) {
      setState(() {
        trainingNo = onValue;
        print(userId);
      });
    });
    getPayList().then((onValue){
      setState(() {
        payList = onValue;
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
          title: Text('VIEW TRAINING LIST'),
          backgroundColor: Colors.purple,
        ),
        body: showUserList());
  }

  Widget showUserList() {
      List <String> id = List <String>();
      for(int i=0 ; i< payList.documents.length ; i++)
        for(int j=0 ; j< trainingNo.documents.length ; j++)
        {
          if(trainingNo.documents[j].documentID == payList.documents[i].data['training_id'])
            {
              id.add(trainingNo.documents[j].documentID);
            }
        }

      print('size ${id.length}');
    if (trainingNo != null && trainingNo.documents != null  ) {
      return ListView.builder(
        itemCount: trainingNo.documents.length,
        itemBuilder: (BuildContext context, index) {
          if(id.contains(trainingNo.documents[index].documentID)){
            return SizedBox(width: 1,);
          }
          else{
          return Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        Icons.payment,
                        size: 50,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CreditCardPay(
                                  trainingNo.documents[index].documentID);
                            },
                          ),
                        );
                      },
                    ),
                    title: Text('${trainingNo.documents[index].data['title']}'),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          child: Text(
                              '${trainingNo.documents[index].data['about']}'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                '${trainingNo.documents[index].data['location']}'),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.monetization_on,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${trainingNo.documents[index].data['price']}')
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                '${trainingNo.documents[index].data['duration']}')
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );}
        },
      );
    } else if (trainingNo != null && trainingNo.documents.length == 0) {
      return Text(
        "No Users!",
        style: TextStyle(fontSize: 19),
      );
    } else {
      print(trainingNo);

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
}
