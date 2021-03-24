import 'package:flutter/material.dart';
import 'package:pi_mobile/pages/drawer/defaultDrawer.dart';
import 'package:pi_mobile/pages/maps/gmap.dart';
import 'package:pi_mobile/widgets/control_screen.dart';

class CoreMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GMap(),
      drawer: DefaultDrawer(),
      floatingActionButton: ControllScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
