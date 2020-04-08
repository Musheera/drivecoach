import 'package:flutter/material.dart';

class ViewDoc extends StatefulWidget {
  String imageURI;
  String title;
  ViewDoc(this.imageURI, this.title);
  @override
  _ViewDocState createState() => _ViewDocState();
}

class _ViewDocState extends State<ViewDoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
      backgroundColor: Colors.purple,),
      body: SizedBox(

        child: Image.network(widget.imageURI,
          fit: BoxFit.cover,
          //scale: .50,
        ),
      ),
    );
  }
}
