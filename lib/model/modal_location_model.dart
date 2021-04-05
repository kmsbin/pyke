import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pi_mobile/model/location_model.dart';

enum InputModifier { to, from }

class ModalLocationModel {
  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  List<Location> locations = [];
  InputModifier currentModifier = InputModifier.to;
  Position initialPosition = Position();
}
