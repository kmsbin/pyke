import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:pi_mobile/model/location_model.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:pi_mobile/resources/locations_connect.dart';
import 'package:rxdart/rxdart.dart';

class ModalLocationBloc extends BlocBase {
  final ModalLocationModel locationModel = ModalLocationModel();
  BuildContext modalContext;
  BehaviorSubject _controller = BehaviorSubject();

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

  TextEditingController get toTextController => locationModel.inputs[InputModifier.to].textController;

  TextEditingController get fromTextController => locationModel.inputs[InputModifier.from].textController;

  List<Location> get locations => locationModel.locations;

  void cleanAllInputs() => locationModel.inputs.forEach((key, value) {
        value.textController.text = "";
        value.coordinate = null;
      });

  void clearInput(InputModifier modifier) {
    locationModel.inputs[modifier].coordinate = null;
    locationModel.inputs[modifier].textController.text = "";
    input.add(locationModel);
  }

  void displayTextValue(String data, InputModifier modifier) {
    setLocations(data);
    locationModel.currentModifier = modifier;
  }

  void setLocations(String query) async {
    if (query.isNotEmpty) {
      locationModel.locations = await LocationsConnect.locationHandler(query, 'santa catarina');
      input.add(locationModel);
    }
  }

  void onSelectedItem(int index) {
    locationModel.inputs[locationModel.currentModifier].textController.text = locationModel.locations[index].placeName;
    locationModel.inputs[locationModel.currentModifier].coordinate = locationModel.locations[index].coordinates;
    locationModel.locations = [];
    input.add(locationModel);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
