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
  Future<Map<String, List<LatLng>>> drawDirections() async {
    print('ready to search');
    var walking = await DirectionHandler.directionHandler(fromWaypoint, toWaypoint, 'walking');
    var cycling = await DirectionHandler.directionHandler(fromWaypoint, toWaypoint, 'cycling');

    return {"walking": walking, "cycling": cycling};
  }
}

class DirectionsHalfFulled extends DirectionEvent {
  @override
  drawDirections() {
    print('NOT ready to search yet');
  }

  DirectionsHalfFulled({fromWaypoint, toWaypoint}) : super(fromWaypoint, toWaypoint);
}
