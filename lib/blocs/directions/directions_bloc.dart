import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/app_module.dart';
import 'package:pi_mobile/blocs/directions/direction_events.dart';
import 'package:pi_mobile/blocs/modal_location_bloc.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pi_mobile/utils.dart';

class DirectionsBloc extends BlocBase {
  DirectionEvent directionEvent = DirectionsHalfFulled();
  List<LatLng> directions;
  MapboxMapController mapController;
  BehaviorSubject _controller = BehaviorSubject();
  BuildContext modalContext;

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

  void stream() {
    var modalController = AppModule.to.bloc<ModalLocationBloc>();
    var inputs = modalController.locationModel.inputs;
    modalController.output.listen((event) async {
      if (inputs[InputModifier.to].coordinate.isNotNull() && inputs[InputModifier.from].coordinate.isNotNull()) {
        var newEvent = DirectionsFulled(fromWaypoint: inputs[InputModifier.from].coordinate, toWaypoint: inputs[InputModifier.to].coordinate);

        if (newEvent != directionEvent) {
          directionEvent = newEvent;
          directions = await directionEvent.drawDirections();
          directionEvent = DirectionsHalfFulled();
          modalController.locationModel.cleanAllInputs();
          setOptions(directions);
          print('\n\ncontext -------- ${modalContext.widget} \n\n');
          Navigator.popUntil(modalContext, ModalRoute.withName('/'));
        }
        print(directions);
        return;
      }
    });
  }

  void setOptions(List<LatLng> coordinates) {
    if (coordinates.length != 0) {
      final optionsLine = new LineOptions(
        geometry: coordinates,
        lineColor: "#D31B77",
        lineWidth: 10.0,
        draggable: false,
        lineOpacity: 1.0,
        lineBlur: 1.0,
      );
      mapController?.addLine(optionsLine);
      mapController?.clearLines();
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
