import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class InputModel {
  final TextEditingController whereController = new TextEditingController();
  final TextEditingController fromController = new TextEditingController();
  List<LatLng> coordinates = [];
  TextEditingController currentLocationsModifier;

  bool isInputFrom = false;
  bool isInputWhere = false;

  String backupFrom;
  String backupWhere;

  LatLng from;
  LatLng where;
  bool firstRender = true;
  List<Address> locations = [];
}
