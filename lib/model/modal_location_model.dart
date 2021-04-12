import 'package:flutter/widgets.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/model/location_model.dart';

enum InputModifier { to, from }

class ModalLocationModel {
  Map<InputModifier, InputCoordinate> inputs = {
    InputModifier.to: InputCoordinate(),
    InputModifier.from: InputCoordinate(),
  };
  List<Location> locations = [];
  InputModifier currentModifier = InputModifier.to;
  Position initialPosition = Position();
}

class InputCoordinate {
  LatLng coordinate;
  TextEditingController textController = TextEditingController();
}
