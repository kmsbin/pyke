import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/app_module.dart';
import 'package:pi_mobile/blocs/controls_bloc.dart';
import 'package:pi_mobile/blocs/directions/direction_events.dart';
import 'package:pi_mobile/blocs/modal_location_bloc.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pi_mobile/utils.dart';

class DirectionsBloc extends BlocBase {
  DirectionEvent directionEvent = DirectionsHalfFulled();
  MapboxMapController mapController;
  BehaviorSubject _controller = BehaviorSubject();
  BuildContext modalContext;
  Map<String, List<LatLng>> allDirections;

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

  void stream() {
    var modalController = AppModule.to.bloc<ModalLocationBloc>();
    var controlsController = AppModule.to.bloc<ControlsBloc>();

    var inputs = modalController.locationModel.inputs;
    modalController.output.listen((event) async {
      if (inputs[InputModifier.to].coordinate.isNotNull() && inputs[InputModifier.from].coordinate.isNotNull()) {
        var newEvent = DirectionsFulled(fromWaypoint: inputs[InputModifier.from].coordinate, toWaypoint: inputs[InputModifier.to].coordinate);

        if (newEvent != directionEvent) {
          directionEvent = newEvent;
          allDirections = await directionEvent.drawDirections();

          routeDraw(controlsController.routeType);

          Navigator.popUntil(modalContext, ModalRoute.withName('/'));
        }
        return;
      }
    });
    controlsController.output.listen((event) {
      routeDraw(controlsController.routeType);
    });
  }

  routeDraw(String routeType) async {
    var modalController = AppModule.to.bloc<ModalLocationBloc>();
    var controlsController = AppModule.to.bloc<ControlsBloc>();
    if (allDirections[controlsController.routeType].length > 0) {
      mapController.addSymbol(SymbolOptions(
          geometry: allDirections[controlsController.routeType].first, // location is 0.0 on purpose for this example
          iconImage: "map_marker"));
      mapController.addSymbol(SymbolOptions(
          geometry: allDirections[controlsController.routeType].last, // location is 0.0 on purpose for this example
          iconImage: "map_marker"));
      directionEvent = DirectionsHalfFulled();
      modalController.cleanAllInputs();

      setOptions(allDirections[controlsController.routeType]);
      print('\n\ncontext -------- ${modalContext.widget} \n\n');
    }
  }

  void setOptions(List<LatLng> coordinates) {
    if (coordinates.length != 0) {
      final optionsLine = new LineOptions(
        geometry: coordinates,
        lineColor: "#D31B77",
        lineWidth: 7.0,
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
