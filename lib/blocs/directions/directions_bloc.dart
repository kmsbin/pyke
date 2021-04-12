import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/blocs/directions/direction_events.dart';
import 'package:pi_mobile/resources/direction_connect.dart';
import 'package:rxdart/rxdart.dart';

extension isNullObj on Object {
  bool isNull<T>() => this == null;
  bool isNotNull<T>() => this != null;
}

class DirectionsBloc extends BlocBase {
  LatLng fromCoordinate;
  LatLng toCoordinate;
  DirectionEvent directionEvent = DirectionsHalfFulled();
  List<LatLng> direction;
  BehaviorSubject _controller = BehaviorSubject();

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;
  DirectionsBloc() : super() {}
  stream() {
    _controller.listen((event) {
      if (fromCoordinate.isNotNull() && toCoordinate.isNotNull()) {
        directionEvent = DirectionsFulled(
            fromWaypoint: fromCoordinate, toWaypoint: toCoordinate);
        directionEvent.drawDirections();

        return;
      }
      if (fromCoordinate.isNotNull() || toCoordinate.isNotNull()) {
        directionEvent = DirectionsHalfFulled(
            fromWaypoint: fromCoordinate, toWaypoint: toCoordinate);
        directionEvent.drawDirections();
        return;
      }
      print('test listen');
    });
  }

  void calculateDirection() async {
    direction = await DirectionHandler.directionHandler(
        fromCoordinate, toCoordinate, 'cycling');

    _controller.add(direction);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
