import 'package:equatable/equatable.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/resources/direction_connect.dart';

abstract class DirectionEvent extends Equatable {
  final LatLng fromWaypoint;
  final LatLng toWaypoint;

  const DirectionEvent(this.fromWaypoint, this.toWaypoint);

  drawDirections() {}

  @override
  List<Object> get props => [drawDirections, fromWaypoint, toWaypoint];
}

class DirectionsFulled extends DirectionEvent {
  const DirectionsFulled({fromWaypoint, toWaypoint}) : super(fromWaypoint, toWaypoint);

  @override
  Future<List<LatLng>> drawDirections() async {
    print('ready to search');
    return await DirectionHandler.directionHandler(fromWaypoint, toWaypoint, 'cycling');
  }
}

class DirectionsHalfFulled extends DirectionEvent {
  @override
  drawDirections() {
    print('NOT ready to search yet');
  }

  DirectionsHalfFulled({fromWaypoint, toWaypoint}) : super(fromWaypoint, toWaypoint);
}
