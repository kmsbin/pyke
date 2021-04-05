import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pi_mobile/model/location_model.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pi_mobile/utils.dart';
import 'package:rxdart/rxdart.dart';

class ModalLocationBloc {
  final ModalLocationModel locationModel = ModalLocationModel();
  Map inputs;

  BehaviorSubject _controller = BehaviorSubject();

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

  TextEditingController get toTextController => locationModel.toController;
  TextEditingController get fromTextController => locationModel.fromController;
  List<Location> get locations => locationModel.locations;

  ModalLocationBloc() : super() {
    inputs = {
      InputModifier.to: locationModel.toController,
      InputModifier.from: locationModel.fromController
    };
  }
  void displayTextValue(String data, InputModifier modifier) {
    setLocations(data);
    locationModel.currentModifier = modifier;
    print(" data:  ${locationModel.toController.text},  modifier: $modifier");
  }

  void setLocations(String query) async {
    if (query.isNotEmpty) {
      try {
        String accessPoint = Utils.ACCESS_POINT_DIRECT_API;
        Response response;
        response = await Dio().get(
            "https://api.mapbox.com/geocoding/v5/mapbox.places/$query+santa+catarina.json?access_token=$accessPoint");
        Locations loc = Locations(response.data);

        locationModel.locations = loc.location;
        _controller.add(locationModel.locations);
      } catch (err) {
        print(err);
      }
      return;
    }
  }

  void onSelectedItem() {
    inputs[locationModel.currentModifier].text = "";
    _controller.add(inputs);
    _controller.add(locationModel);
  }

  void setInputValue(data) {
    _controller.add(data);
  }

  void dispose() {
    _controller.close();
  }
}
