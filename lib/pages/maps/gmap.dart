import 'package:flutter/material.dart';
import 'package:pi_mobile/app_module.dart';
import 'package:pi_mobile/blocs/directions/directions_bloc.dart';
import 'package:pi_mobile/utils.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff030d22),
        child: FutureBuilder(
            future: Utils.position,
            builder: (context, snapshot) {
              Utils.positions = snapshot.data;
              print(snapshot.data);
              print("\n----------------BUILDING------------------\n");
              if (snapshot.hasData) {
                return MapboxMap(
                  compassEnabled: true,
                  // myLocationEnabled: true,
                  // myLocationRenderMode: MyLocationRenderMode.NORMAL,
                  myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                  minMaxZoomPreference: MinMaxZoomPreference(12, 16.5),
                  // myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
                  onMapCreated: (MapboxMapController currentController) {
                    AppModule.to.bloc<DirectionsBloc>().mapController = currentController;
                  },
                  styleString: "mapbox://styles/kauli/ckjm7zesn1m7t1aqgh0ysbtb0",
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data.latitude, snapshot.data.longitude),
                    zoom: 15,
                  ),
                );
              } else {
                return Container(
                  color: const Color(0xff030d22),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffD31B77)),
                      backgroundColor: const Color(0xff030d22),
                    ),
                  ),
                );
              }
            }));
  }
}
