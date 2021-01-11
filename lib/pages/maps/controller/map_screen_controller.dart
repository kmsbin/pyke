import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/pages/maps/model/input_model.dart';

import '../../../utils.dart';

class MapScreenController extends ChangeNotifier {
  String getWhere() => this._inputModel.whereController.text;
  InputModel _inputModel = new InputModel();
  MapboxMapController mapController;
  Address currentClientPosition;

  void directionsHandler(LatLng fromWaypoint, LatLng whereWaypoint) async {
    var listDirect = await requestDirection(fromWaypoint, whereWaypoint);
    this._inputModel.coordinates = unMarshal(listDirect);
    // print(unMarshal(listDirect));
    this.notifyListeners();
  }

  void updateScreen() => this.notifyListeners();
  Future<Map<dynamic, dynamic>> requestDirection(
      LatLng fromWaypoint, LatLng whereWaypoint) async {
    Response response;
    Dio dio = new Dio();
    String accessPoint = Utils.ACCESS_POINT_DIRECT_API;
    final String uri =
        "https://api.mapbox.com/directions/v5/mapbox/cycling/${fromWaypoint.longitude}%2C${fromWaypoint.latitude}%3B${whereWaypoint.longitude}%2C${whereWaypoint.latitude}?alternatives=true&geometries=geojson&steps=false&access_token=$accessPoint";
    response = await dio.get(uri);
    return response.data;
  }

  LatLng get where => this._inputModel.where;
  LatLng get from => this._inputModel.from;

  List<LatLng> get coordinates => this._inputModel.coordinates;

  TextEditingController get fromController => this._inputModel.fromController;
  TextEditingController get whereController => this._inputModel.whereController;
  TextEditingController get currentLocationsModifier =>
      this._inputModel.currentLocationsModifier;

  bool get isInputFrom => this._inputModel.isInputFrom;
  bool get isInputWhere => this._inputModel.isInputWhere;

  set currentLocationsModifier(TextEditingController newCurrent) {
    this._inputModel.currentLocationsModifier = newCurrent;
    this.notifyListeners();
  }

  set where(dynamic newWhere) {
    this._inputModel.where = newWhere;
    this.notifyListeners();
  }

  set isInputFrom(bool isInputFrom) {
    this._inputModel.isInputFrom = isInputFrom;
  }

  set isInputWhere(bool isInputWhere) {
    this._inputModel.isInputWhere = isInputWhere;
  }

  List<LatLng> unMarshal(Map req) {
    List rawCoordinates = req['routes'].first['geometry']['coordinates'];
    List<LatLng> coordinates = new List<LatLng>();
    rawCoordinates
        .forEach((e) async => coordinates.add(LatLng(e?.last, e?.first)));
    // print("\n----- $coordinates --------\n");
    return coordinates;
  }

  void setWhere(String newWhere) async {
    if (this._inputModel.backupWhere != newWhere) {
      this._inputModel.backupWhere = newWhere;
      setLocations(this._inputModel.whereController.text);
    }
    if (this.currentLocationsModifier != this.whereController) {
      this.currentLocationsModifier = this.whereController;
    }
  }

  void setFrom(String newFrom) async {
    if (this._inputModel.backupFrom != newFrom) {
      this._inputModel.backupFrom = newFrom;
      this._inputModel.currentLocationsModifier =
          this._inputModel.fromController;
      setLocations(this._inputModel.fromController.text);
    }
  }

  void initFromInput(Position position) async {
    if (this._inputModel.firstRender) {
      this._inputModel.firstRender = false;
      List<Address> address = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(position.latitude, position.longitude));
      this._inputModel.from = LatLng(position.latitude, position.longitude);
      this.currentClientPosition = address.first;
      this._inputModel.fromController.text = address.first.addressLine;
      notifyListeners();
    }
  }

  void setLocations(String query) async {
    if (query.isNotEmpty) {
      try {
        List<Address> newLoc =
            await Geocoder.local.findAddressesFromQuery(query);
        List<Address> filtred = List<Address>();
        newLoc.forEach((address) {
          //adminArea: Estado
          if (address.adminArea == this.currentClientPosition?.adminArea) {
            // print("\n-----------------Location: zsdfgbnsdb\n");
            filtred.add(address);
          }
        });

        this._inputModel.locations = filtred;
        notifyListeners();
        // print(newLoc);
      } catch (err) {
        print(err);
      }
      return;
    }
    this.cleanLocationList();
  }

  void openModal() {
    this._inputModel.whereController.text = '';
  }

  void cleanLocationList() {
    this._inputModel.locations = [];
    notifyListeners();
  }

  List<Address> getLocations() {
    return this._inputModel.locations;
  }

  void closeModal(BuildContext context) {
    if (!this.isShowModal) {
      Navigator.pop(context);
    }
  }

  void calculateDistance() {
    if (this.isShowModal) {
      LatLng a = this._inputModel.where;
      LatLng b = this._inputModel.from;
      double catetoBC = pow(b.longitude - a.longitude, 2);
      double catetoAC = pow(b.latitude - a.latitude, 2);
      double distance = sqrt(catetoAC + catetoBC) * (40.075 / 360);
      double zoom = 0;
      double remainder = distance * 1000;
      while (remainder > 0.01) {
        () {
          if (remainder > 0.01) {
            zoom = zoom + 0.01;
            remainder = remainder / 2;
            return;
          }
          if (remainder > 0.1) {
            zoom = zoom + 0.1;
            remainder = remainder / 2;
            return;
          }
          if (remainder > 0) {
            zoom++;
            remainder = remainder / 2;
            return;
          }
        }();
      }
      print("\n A DISTANCIA ENTRE OS PONTOS SÃO :: ${distance}KM -------- \n");
    }
  }

  void onSelectedItem(int index, context) {
    mapController.clearLines();
    this._inputModel.currentLocationsModifier.text =
        this.getLocations()[index].addressLine;
    Coordinates coord = this.getLocations()[index].coordinates;
    final int fromHash = this._inputModel.fromController.hashCode;
    final int currentHash = this._inputModel.currentLocationsModifier.hashCode;
    final int whereHash = this._inputModel.whereController.hashCode;
    closeModal(context);
    if (fromHash == currentHash) {
      this._inputModel.from = LatLng(coord.latitude, coord.longitude);
      calculateDistance();
      this._inputModel.fromController.text = "";
      this.directionsHandler(this.where, this.from);
      this.cleanLocationList();
      return;
    }
    if (whereHash == currentHash) {
      this._inputModel.where = LatLng(coord.latitude, coord.longitude);
      calculateDistance();
      this._inputModel.whereController.text = "";
      this.directionsHandler(this.where, this.from);
      this.cleanLocationList();
      return;
    }
  }

  bool get isShowModal =>
      this._inputModel.where != null && this._inputModel.from != null;

  String getFrom() => this._inputModel.fromController.text;
}
