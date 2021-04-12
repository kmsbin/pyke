import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:pi_mobile/utils.dart';

class DirectionHandler {
  static Future<List<LatLng>> directionHandler(LatLng fromWaypoint, LatLng whereWaypoint, String routeType) async {
    return unMarshal(await requestDirection(fromWaypoint, whereWaypoint, routeType));
  }

  static Future<Map<dynamic, dynamic>> requestDirection(LatLng fromWaypoint, LatLng whereWaypoint, String routeType) async {
    Response response;
    Dio dio = new Dio();
    String accessPoint = Utils.ACCESS_POINT_DIRECT_API;
    final String uri = "https://api.mapbox.com/directions/v5/mapbox/$routeType/${fromWaypoint.longitude}%2C${fromWaypoint.latitude}%3B${whereWaypoint.longitude}%2C${whereWaypoint.latitude}?alternatives=true&geometries=geojson&steps=false&access_token=$accessPoint";
    response = await dio.get(uri);
    return response.data;
  }

  static List<LatLng> unMarshal(Map req) {
    List rawCoordinates = req['routes'].first['geometry']['coordinates'];
    List<LatLng> coordinates = [];
    rawCoordinates.forEach((e) async => coordinates.add(LatLng(e?.last, e?.first)));
    // print("\n----- $coordinates --------\n");
    return coordinates;
  }
}
