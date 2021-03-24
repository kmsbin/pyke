import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';

class Locations {
  List<Location> location = [];
  String placeName;
  LatLng coordinates;
  // Locations(location);

  // Locations(location);

  Locations(String map) {
    var jsondata = json.decode(map);
    // print("\n\n\n ${jsondata['features']}  \n\n\n");
    // List<Location> location = List<Location>();
    jsondata['features'].forEach((value) {
      print("\n${value["center"][1]}, ${value["center"][0]}");
      location.add(Location(
          placeName: value["place_name"],
          coordinates: LatLng(value["center"][1], value["center"][0])));
    });
  }
}

class Location {
  String placeName;
  LatLng coordinates;

  Location({this.placeName, this.coordinates});
}
