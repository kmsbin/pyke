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
  String _backupFrom;
  String _backupWhere;
  LatLng _from;
  LatLng _where;
  bool firstRender = true;
  List<Address> locations = [];

  LatLng get where => this._where;
  String get backupFrom => this._backupFrom;
  String get backupWhere => this._backupWhere;
  LatLng get from => this._from;

  set backupFrom(final String newBackupFrom) =>
      this._backupFrom = newBackupFrom;
  set backupWhere(final String newBackupWhere) =>
      this._backupWhere = newBackupWhere;
  set from(final LatLng newFrom) => _from = newFrom;
  set where(final LatLng newWhere) => _where = newWhere;
}
