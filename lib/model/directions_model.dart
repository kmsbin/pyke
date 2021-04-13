import 'package:mapbox_gl/mapbox_gl.dart';

class DirectionModel {
  LatLng fromWaypoint;
  LatLng toWaypoint;

  MapboxMapController controller;

  List<LatLng> directions = [];
}
