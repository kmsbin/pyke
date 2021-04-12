import 'package:dio/dio.dart';
import 'package:geocoder/model.dart';
import 'package:pi_mobile/model/location_model.dart';
import 'package:pi_mobile/utils.dart';

class LocationsConnect {
  static Future<List<Location>> locationHandler(String query, String currentClientPosition) async {
    String accessPoint = Utils.ACCESS_POINT_DIRECT_API;
    Response response;
    response = await Dio().get("https://api.mapbox.com/geocoding/v5/mapbox.places/$query $currentClientPosition.json?access_token=$accessPoint");
    Locations loc = Locations(response.data);

    return loc.location;
  }
}
