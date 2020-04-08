import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_map_location_picker/generated/i18n.dart';
import 'admin_main_Screen.dart';
import 'credit_card.dart';

class ViewRating extends StatefulWidget {
  double no;

  ViewRating(this.no);

  @override
  _ViewRatingState createState() => _ViewRatingState();
}

class _ViewRatingState extends State<ViewRating> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIEW TRAINING LIST'),
        backgroundColor: Colors.purple,
      ),
      body: StarRating(
        size: 20.0,
        rating: widget.no,
        color: Colors.orange,
        borderColor: Colors.grey,
      ),
    );
  }

}
