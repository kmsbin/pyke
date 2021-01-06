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
                        lineColor: "#000000",
                        lineWidth: 10.0,
                        draggable: false);
                    mapController?.addLine(options);
                    mapController.clearLines();
                  }
                  print("Objet detection <Where> and <From>");
                }

                return MapboxMap(
                  compassEnabled: true,
                  myLocationTrackingMode:
                      MyLocationTrackingMode.TrackingCompass,
                  onMapCreated: (MapboxMapController currentController) {
                    mapController = currentController;
                    provider.mapController = currentController;
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(-27.003581, -48.637051), zoom: 20.0),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
