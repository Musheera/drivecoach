import 'package:flutter/material.dart';


class pageModel {
  String _title;
  String _img;
  String _description;
  String _logo;

  pageModel(this._title, this._img, this._description, this._logo);

  String get logo => _logo;

  String get description => _description;

  String get img => _img;

  String get title => _title;


}