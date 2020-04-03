import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/screen/view_traffic_rule.dart';
import 'package:drivecoach/screen/view_traffic_users.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateRule extends StatefulWidget {
  @override
  _UpdateRuleState createState() => _UpdateRuleState();
  DocumentSnapshot document;

  UpdateRule(this.document);
}

class _UpdateRuleState extends State<UpdateRule> {
  String _title;
  String _article;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("UPDATE TRAFFIC RULES"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Rule title",
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Trafic rule title is required';
                  }
                  else return null;
                },
                onSaved: (val)=> _title = val,
                initialValue: widget.document.data['title'],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 48,
                  right: 48,
                ),
              ),
              TextFormField(
                maxLines: 13,
                decoration: InputDecoration(
                  hintMaxLines: 20,
                  hintText: "Traffic rule",
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Traffic rule is required';
                  }
                  else return null;
                },
                onSaved: (val)=> _article = val,
                initialValue: widget.document.data['rule'],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.purple,
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 1),
                  ),
                  onPressed: () async {
                         updateRule(widget.document.documentID,{'title': _title, 'rule': _article});

                    Fluttertoast.showToast(
                        msg: "The traffic rule has beed updated");

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateRule (String RuleId,  data) async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      print(_title);
      Firestore.instance.collection('rules')
      .document(RuleId)
      .setData(data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ViewRuleList();
          },
        ),
      );
  }}


}
