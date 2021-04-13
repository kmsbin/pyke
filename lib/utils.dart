import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

extension isNullObj on Object {
  bool isNull<T>() => this == null;
  bool isNotNull<T>() => this != null;
}

class Utils {
  static Future<Position> get position async {
    try {
      List<Address> newLoc = await Geocoder.local.findAddressesFromQuery("Balneário Camboriú");
      print(newLoc[0].addressLine);
      print(newLoc);
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      bool _serviceEnabled;

      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        var serviceEnabled = await Geolocator.requestPermission();
        if (serviceEnabled == LocationPermission.whileInUse || serviceEnabled == LocationPermission.always) {
          return position;
        } else {}
      }
      return position;
    } catch (e) {
      return e;
    }
  }

  static final String API_KEY = env['MAPBOX_KEY'];
  static final String ACCESS_POINT_DIRECT_API = env['MAPBOX_KEY'];
}
