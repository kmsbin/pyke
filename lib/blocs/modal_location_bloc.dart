import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/app_module.dart';
import 'package:pi_mobile/blocs/directions/directions_bloc.dart';
import 'package:pi_mobile/model/location_model.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pi_mobile/utils.dart';
import 'package:rxdart/rxdart.dart';

class ModalLocationBloc extends BlocBase {
  static final ModalLocationModel locationModel = ModalLocationModel();
  Map inputs = locationModel.inputs;

  BehaviorSubject _controller = BehaviorSubject();

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

  TextEditingController get toTextController =>
      inputs[InputModifier.to].textController;

  TextEditingController get fromTextController =>
      inputs[InputModifier.from].textController;

  List<Location> get locations => locationModel.locations;

  ModalLocationBloc() : super() {}
  void displayTextValue(String data, InputModifier modifier) {
    setLocations(data);
    locationModel.currentModifier = modifier;
    print(
        " data:  ${locationModel.inputs[modifier].textController.text},  modifier: $modifier");
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
        input.add(locationModel.locations);
        _controller.add(locationModel);
      } catch (err) {
        print(err);
      }
      return;
    }
  }

  void onSelectedItem(int index) {
    DirectionsBloc directController = AppModule.to.bloc<DirectionsBloc>();
    inputs[locationModel.currentModifier].textController.text =
        locationModel.locations[index].placeName;
    var coord = locationModel.locations[index].coordinates;
    inputs[locationModel.currentModifier].coordinate =
        locationModel.locations[index].coordinates;
    if (locationModel.currentModifier == InputModifier.from) {
      AppModule.to.bloc<DirectionsBloc>().fromCoordinate =
          locationModel.locations[index].coordinates;

      AppModule.to
          .bloc<DirectionsBloc>()
          .input
          .add(AppModule.to.bloc<DirectionsBloc>());
      print('entrou from');
    }
    if (locationModel.currentModifier == InputModifier.to) {
      AppModule.to.bloc<DirectionsBloc>().toCoordinate =
          locationModel.locations[index].coordinates;
      AppModule.to
          .bloc<DirectionsBloc>()
          .input
          .add(AppModule.to.bloc<DirectionsBloc>());
      print('entrou to');
    }

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
