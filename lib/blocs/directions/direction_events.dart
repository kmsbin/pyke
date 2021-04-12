import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

abstract class DirectionEvent extends Equatable {
  final LatLng fromWaypoint;
  final LatLng toWaypoint;

  const DirectionEvent({this.fromWaypoint, this.toWaypoint});

  drawDirections() {}

  @override
  List<Object> get props => [drawDirections, fromWaypoint, toWaypoint];
}

class DirectionsFulled extends DirectionEvent {
  const DirectionsFulled({fromWaypoint, toWaypoint})
      : super(fromWaypoint: fromWaypoint, toWaypoint: toWaypoint);

  @override
  drawDirections() {
    print('ready to search');
  }
}

class DirectionsHalfFulled extends DirectionEvent {
  @override
  drawDirections() {
    print('NOT ready to search yet');
  }

  DirectionsHalfFulled({fromWaypoint, toWaypoint})
      : super(fromWaypoint: fromWaypoint, toWaypoint: toWaypoint);
}
