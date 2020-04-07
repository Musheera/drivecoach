import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/generated/i18n.dart';
import 'admin_main_Screen.dart';
import 'credit_card.dart';

class ViewTrainingListUsers extends StatefulWidget {
  @override
  _ViewTrainingListUsersState createState() => _ViewTrainingListUsersState();
}




class _ViewTrainingListUsersState extends State<ViewTrainingListUsers> {
  QuerySnapshot trainingNo;
  QuerySnapshot traineeNo;

  @override
  void initState() {
    super.initState();
    getTrainings().then((data) {
      setState(() {
        trainingNo = data;
      });
    });
  }


  getTraineePay(String userId, String trainingId) async {
    return Firestore.instance.collection('payment').where(
        'trainee_id', isEqualTo: userId).where(
        'training_id', isEqualTo: trainingId).getDocuments();
  }

  getTrainings() async {
    return await Firestore.instance.collection('training').getDocuments();
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
//    List <DocumentSnapshot> qSnapshot;
//
//    for(int i=0; i< trainingNo.documents.length ; i++){
//      if(traineeNo.documents[i].data['trainee_id'] == userId && trainingNo.documents[i].documentID ==  traineeNo.documents[i].data['training_id'])
//        {
//          qSnapshot.add(trainingNo.documents);
//        }
//    }
    if (trainingNo != null && trainingNo.documents != null) {
      return ListView.builder(
        itemCount: trainingNo.documents.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            child: Container(
              child: Column(
                children: <Widget>[
                SizedBox(
                height: 10,
              ),
              ListTile(
                  trailing: viewCard(trainingNo.documents[index].documentID),
              title: Text(
                  '${trainingNo.documents[index].data['title']}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(child: Text(
                      '${trainingNo.documents[index].data['about']}'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.purple,),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          '${trainingNo.documents[index]
                              .data['location']}'),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on, color: Colors.purple,),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          '${trainingNo.documents[index]
                              .data['price']}')
                    ],
                  ),

                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.timer, color: Colors.purple,),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          '${trainingNo.documents[index]
                              .data['duration']}')
                    ],
                  ),
                ],
              ),
            ),

            ],
          ),)
          ,
          );

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

  Widget viewCard(String documentID) {
    if (getTraineePay(userId, documentID) != null) {
      print("user $userId");
      print(" id $documentID");

      return IconButton(
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
                    documentID);
              },
            ),
          );
        },
      );
    }
    else {return Text("Paid");}
  }
}
