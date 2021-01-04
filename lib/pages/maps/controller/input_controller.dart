import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/pages/maps/model/input_model.dart';

import '../../../utils.dart';

class InputController extends ChangeNotifier with InputModel {
  String getWhere() => whereController.text;

  void directionsHandler(LatLng fromWaypoint, LatLng whereWaypoint) async {
    var listDirect = await requestDirection(fromWaypoint, whereWaypoint);
    // List<LatLng> direction = unMarshal(listDirect);
    this.coordinates = unMarshal(listDirect);
    print(unMarshal(listDirect));
    this.notifyListeners();
  }

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

  List<LatLng> unMarshal(Map req) {
    List rawCoordinates = req['routes'].first['geometry']['coordinates'];
    List<LatLng> coordinates = new List<LatLng>();
    rawCoordinates
        .forEach((e) async => coordinates.add(LatLng(e?.last, e?.first)));
    // print("\n----- $coordinates --------\n");
    return coordinates;
  }

  void setWhere(String newWhere) async {
    if (backupWhere != newWhere) {
      backupWhere = newWhere;
      currentLocationsModifier = whereController;
      setLocations(whereController.text);
    }
  }

  void setFrom(String newFrom) async {
    if (backupFrom != newFrom) {
      backupFrom = newFrom;
      currentLocationsModifier = fromController;
      setLocations(fromController.text);
    }
  }

  void initFromInput(Position position) async {
    if (this.firstRender) {
      this.firstRender = false;
      List<Address> address = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(position.latitude, position.longitude));
      this.from = LatLng(position.latitude, position.longitude);
      this.fromController.text = address.first.addressLine;
      notifyListeners();
    }
  }

  void setLocations(String query) async {
    if (query.isNotEmpty) {
      try {
        List<Address> newLoc =
            await Geocoder.local.findAddressesFromQuery(query);
        this.locations = newLoc;
        // print(newLoc);
      } catch (err) {
        print(err);
      }
      return;
    }
    this.cleanLocationList();
  }

  void cleanLocationList() {
    this.locations = [];
    notifyListeners();
  }

  List<Address> getLocations() {
    return this.locations;
  }

  void onSelectedItem(int index) {
    this.currentLocationsModifier.text = this.getLocations()[index].addressLine;
    Coordinates coord = this.getLocations()[index].coordinates;
    if (this.fromController.hashCode ==
        this.currentLocationsModifier.hashCode) {
      this.from = LatLng(coord.latitude, coord.longitude);
      this.isInputFrom = true;
    }
    if (this.whereController.hashCode ==
        this.currentLocationsModifier.hashCode) {
      this.where = LatLng(coord.latitude, coord.longitude);
      this.isInputWhere = true;
    }
    this.cleanLocationList();
  }

  String getFrom() => this.fromController.text;
}
