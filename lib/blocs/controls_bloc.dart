import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

enum RouteType { cycling, walking }

class ControlsBloc extends BlocBase {
  String _routeType = 'cycling';

  BehaviorSubject _controller = BehaviorSubject();

  Sink get input => _controller.sink;
  Stream get output => _controller.stream;

  String get routeType => _routeType;

  void changeRouteType(RouteType newRouteType) {
    _routeType = describeEnum(newRouteType);
    input.add(_routeType);
    _controller.add(_routeType);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
