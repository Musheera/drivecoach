import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/screen/view_traffic_rule.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewRuleDetail extends StatefulWidget {
  @override
  _ViewRuleDetailState createState() => _ViewRuleDetailState();
  DocumentSnapshot document;

  ViewRuleDetail(this.document);
}

class _ViewRuleDetailState extends State<ViewRuleDetail> {

  String _title;
  String _article;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("View TRAFFIC RULES"),),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              ListTile(

                title: Text('${widget.document.data['title']}',
                  style: TextStyle(color: Colors.purple,),),
                subtitle: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text('${widget.document.data['rule']}'),

                    ],),
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
        ));


  }

}
