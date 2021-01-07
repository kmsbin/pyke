import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pi_mobile/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'controller/map_screen_controller.dart';

class GMap extends StatefulWidget {
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  MapboxMapController mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  // String _mapStyle = "";

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.json').then((string) {
      // _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff030d22),
        child: FutureBuilder(
            future: Utils.position,
            builder: (context, snapshot) {
              print("\n----------------BUILDING------------------\n");
              if (snapshot.hasData) {
                var provider = Provider.of<MapScreenController>(context);
                provider.initFromInput(snapshot.data);
                // _createPolylines();
                if (provider.isShowModal) {
                  if (provider.coordinates.length != 0) {
                    final LineOptions options = new LineOptions(
                      geometry: provider.coordinates,
                      lineColor: "#D31B77",
                      lineWidth: 10.0,
                      draggable: false,
                      lineOpacity: 1.0,
                      lineBlur: 1.0,
                    );
                    mapController?.addLine(options);
                    mapController.clearLines();
                  }
                  print("Objet detection <Where> and <From>");
                }
                return MapboxMap(
                  compassEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference(12, 16.5),
                  myLocationTrackingMode:
                      MyLocationTrackingMode.TrackingCompass,
                  onMapCreated: (MapboxMapController currentController) {
                    mapController = currentController;
                    provider.mapController = currentController;
                  },
                  styleString:
                      "mapbox://styles/kauli/ckjm2tkgp14nu19n24yfw8m20",
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-27.003581, -48.637051),
                    zoom: 16.5,
                  ),
                );
              } else {
                return Container(
                  color: const Color(0xff030d22),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffD31B77)),
                      backgroundColor: const Color(0xff030d22),
                    ),
                  ),
                );
              }
            }));
  }
}
