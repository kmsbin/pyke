import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:pi_mobile/model/location_model.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:pi_mobile/resources/locations_connect.dart';
import 'package:rxdart/rxdart.dart';

class ModalLocationBloc extends BlocBase {
  final ModalLocationModel locationModel = ModalLocationModel();
  Map inputs;

  BehaviorSubject _controller = BehaviorSubject();

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

  TextEditingController get toTextController => inputs[InputModifier.to].textController;

  TextEditingController get fromTextController => inputs[InputModifier.from].textController;

  List<Location> get locations => locationModel.locations;

  ModalLocationBloc() : super() {
    inputs = locationModel.inputs;
  }

  void displayTextValue(String data, InputModifier modifier) {
    setLocations(data);
    locationModel.currentModifier = modifier;
    // print(" data:  ${locationModel.inputs[modifier].textController.text},  modifier: $modifier");
  }

  void setLocations(String query) async {
    if (query.isNotEmpty) {
      locationModel.locations = await LocationsConnect.locationHandler(query, 'santa catarina');
      _controller.add(locationModel);
    }
  }

  void onSelectedItem(int index) {
    inputs[locationModel.currentModifier].textController.text = locationModel.locations[index].placeName;
    inputs[locationModel.currentModifier].coordinate = locationModel.locations[index].coordinates;
    locationModel.locations = [];
    _controller.add(inputs);
    _controller.add(locationModel);
  }

  void setInputValue(data) {
    _controller.add(data);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
