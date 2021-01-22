import 'package:flutter/material.dart';
import 'package:pi_mobile/utils.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'controller/map_screen_controller.dart';

class GMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapScreenController>(context);
    var position = Utils.position;
    position.then((value) => provider.initFromInput(value));

    return Container(
        color: const Color(0xff030d22),
        child: FutureBuilder(
            future: Utils.position,
            builder: (context, snapshot) {
              print("\n----------------BUILDING------------------\n");
              if (snapshot.hasData) {
                // provider.position(snapshot.data);
                // provider.position = snapshot.data;
                provider.initFromInput(snapshot.data);
                provider.position = snapshot.data;
                // _createPolylines();
                // if (provider.isShowModal) {
                //   if (provider.coordinates.length != 0) {
                //     final LineOptions options = new LineOptions(
                //       geometry: provider.coordinates,
                //       lineColor: "#D31B77",
                //       lineWidth: 10.0,
                //       draggable: false,
                //       lineOpacity: 1.0,
                //       lineBlur: 1.0,
                //     );
                //     provider.mapController?.addLine(options);
                //     // mapController.updateLine(snapshot.data.p, changes)
                //     provider.mapController?.clearLines();
                //   }
                // }
                provider.setOptions();
                return MapboxMap(
                  compassEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference(12, 16.5),
                  myLocationTrackingMode:
                      MyLocationTrackingMode.TrackingCompass,
                  onMapCreated: (MapboxMapController currentController) {
                    provider.mapController = currentController;
                  },
                  styleString:
                      "mapbox://styles/kauli/ckjm2tkgp14nu19n24yfw8m20",
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(snapshot.data.latitude, snapshot.data.longitude),
                    zoom: 15,
                  ),
                );
              } else {
                return Container(
                  color: const Color(0xff030d22),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xffD31B77)),
                      backgroundColor: const Color(0xff030d22),
                    ),
                  ),
                );
              }
            }));
  }
}
