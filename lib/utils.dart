import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'keys.dart';

class Utils {
  static Future<Position> get position async {
    try {
      List<Address> newLoc =
          await Geocoder.local.findAddressesFromQuery("Balneário Camboriú");
      print(newLoc[0].addressLine);
      print(newLoc);
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      bool _serviceEnabled;

      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        var serviceEnabled = await Geolocator.requestPermission();
        if (serviceEnabled == LocationPermission.whileInUse ||
            serviceEnabled == LocationPermission.always) {
          return position;
        } else {}
      }
      return position;
    } catch (e) {
      return e;
    }
  }

  static const String API_KEY = "AIzaSyBvszasdqF8iSAMuV9DLXd50TxYRtJaVp0";
  static const String ACCESS_POINT_DIRECT_API = MAPBOX_KEY;
}
