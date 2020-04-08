import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_main_Screen.dart';

class ViewTrainingList extends StatefulWidget {
  @override
  _ViewTrainingListState createState() => _ViewTrainingListState();
}

getTrainings() async {
  return await Firestore.instance.collection('training').getDocuments();
}

class _ViewTrainingListState extends State<ViewTrainingList> {
  QuerySnapshot trainingNo;

  @override
  void initState() {
    super.initState();
    getTrainings().then((data) {
      setState(() {
        trainingNo = data;
      });
    });
  }

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
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        trainingNo.documents[index].reference.delete();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ViewTrainingList()),
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
                    title: Text('${trainingNo.documents[index].data['title']}'),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(child: Text('${trainingNo.documents[index].data['about']}'),
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
                                '${trainingNo.documents[index].data['location']}'),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.monetization_on, color: Colors.purple,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                '${trainingNo.documents[index].data['price']}')
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
                                '${trainingNo.documents[index].data['duration']}')
                          ],
                        ),
                     ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      );
    } else if (trainingNo != null && trainingNo.documents.length == 0) {
      return Text(
        "No Training Course!",
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
