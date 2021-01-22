import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/pages/maps/api_connects/direction_connect.dart';
import 'package:pi_mobile/pages/maps/model/input_model.dart';
import 'package:pi_mobile/pages/maps/model/location_model.dart';
import '../model/location_model.dart';

import '../../../utils.dart';

class MapScreenController extends ChangeNotifier {
  String getWhere() => this._inputModel.whereController.text;
  InputModel _inputModel = new InputModel();
  MapboxMapController mapController;
  Address currentClientPosition;
  String routeType;
  Position position;
  LineOptions options;

  void updateScreen() => this.notifyListeners();

  void directionsHandler(LatLng fromWaypoint, LatLng whereWaypoint) async {
    var listDirect = await DirectionHandler.requestDirection(
        fromWaypoint, whereWaypoint, routeType);
    this._inputModel.coordinates = DirectionHandler.unMarshal(listDirect);
    this.notifyListeners();
  }

  LatLng get where => this._inputModel.where;
  LatLng get from => this._inputModel.from;
  List<Location> get locations => this._inputModel.locations;
  set locations(locate) => this._inputModel.locations = locate;

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

  void setWhere(String newWhere) async {
    if (this._inputModel.backupWhere != newWhere) {
      setLocations(this._inputModel.whereController.text);
      this._inputModel.backupWhere = newWhere;
    }
    if (this.currentLocationsModifier != this._inputModel.whereController) {
      this.currentLocationsModifier = this._inputModel.whereController;
      this.cleanLocationList();
    }
  }

  void setFrom(String newFrom) async {
    if (this._inputModel.backupFrom != newFrom) {
      this._inputModel.backupFrom = newFrom;
      // this._inputModel.currentLocationsModifier = this._inputModel.fromController;
      setLocations(this._inputModel.fromController.text);
    }
    if (this.currentLocationsModifier != this._inputModel.fromController) {
      this.currentLocationsModifier = this._inputModel.fromController;
      this.cleanLocationList();
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
        // print("antes de buscar os address");
        String accessPoint = Utils.ACCESS_POINT_DIRECT_API;
        Response response;
        response = await Dio().get(
            "https://api.mapbox.com/geocoding/v5/mapbox.places/$query ${this.currentClientPosition?.adminArea}.json?access_token=$accessPoint");
        Locations loc = Locations(response.data);

        locations = loc.location;
        // print("\n\n\n init counting");
        locations.forEach((element) {
          // print("\n latitude item: ${element.placeName}");
        });

        // print(
        // "\n\n\n\n ${loc.location.first.coordinates.latitude}, ${loc.location.first.coordinates.longitude} \n\n\n");
        // List<Address> newLoc =
        //     await Geocoder.local.findAddressesFromQuery(query);

        // List<Address> filtred = List<Address>();
        // print(newLoc);
        // newLoc.forEach((address) {
        //   //adminArea: Estado
        //   if (address.adminArea == this.currentClientPosition?.adminArea) {
        //     // print("\n-----------------Location: zsdfgbnsdb\n");
        //     filtred.add(address);
        //   }
        // });

        // this._inputModel.locations = filtred;
        notifyListeners();
        // print(newLoc);
      } catch (err) {
        print(err);
      }
      return;
    }
    this.cleanLocationList();
  }

  void cleanLocationList() {
    this._inputModel.locations = [];
    notifyListeners();
  }

  void closeModal(BuildContext context) {
    print(
        "\n -------- ${this._inputModel.where}  -----  ${this._inputModel.from}");
    if (this.isShowModal) {
      this._inputModel.where = null;
      this._inputModel.from = null;
      this._inputModel.fromController.text = "";
      this._inputModel.whereController.text = "";
      cleanLocationList();
      notifyListeners();
      Navigator.pop(context);
    }
  }

  void setOptions() {
    if (this._inputModel.coordinates.length != 0) {
      final optionsLine = new LineOptions(
        geometry: this._inputModel.coordinates,
        lineColor: "#D31B77",
        lineWidth: 10.0,
        draggable: false,
        lineOpacity: 1.0,
        lineBlur: 1.0,
      );
      mapController?.addLine(optionsLine);
      // mapController.updateLine(snapshot.data.p, changes)
      mapController?.clearLines();
      notifyListeners();
    }
  }

  void onSelectedItem(int index, context) {
    mapController.clearLines();
    this._inputModel.currentLocationsModifier.text =
        this.locations[index].placeName;
    final int fromHash = this._inputModel.fromController.hashCode;
    final int currentHash = this._inputModel.currentLocationsModifier.hashCode;
    final int whereHash = this._inputModel.whereController.hashCode;
    if (fromHash == currentHash) {
      this._inputModel.from = this.locations[index].coordinates;
      this.directionsHandler(this.where, this.from);
      closeModal(context);
      this._inputModel.currentLocationsModifier = null;
      return;
    }
    if (whereHash == currentHash) {
      this._inputModel.where = this.locations[index].coordinates;
      this.directionsHandler(this.where, this.from);
      closeModal(context);
      this._inputModel.currentLocationsModifier = null;
      return;
    }
  }

  bool get isShowModal =>
      this._inputModel.where != null && this._inputModel.from != null;

  String getFrom() => this._inputModel.fromController.text;
}
