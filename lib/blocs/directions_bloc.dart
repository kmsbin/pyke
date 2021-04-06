import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/resources/direction_connect.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class DirectionsBloc extends BlocBase {
  LatLng fromCoordinate;
  LatLng toCoordinate;
  List<LatLng> direction;
  BehaviorSubject _controller = BehaviorSubject();

  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

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
