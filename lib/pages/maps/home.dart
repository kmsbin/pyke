import 'package:flutter/material.dart';
import 'package:pi_mobile/pages/maps/controller/input_controller.dart';
import 'package:pi_mobile/pages/maps/gmap.dart';
import 'package:pi_mobile/pages/maps/input_modal.dart';
import 'package:provider/provider.dart';

class CoreMaps extends StatefulWidget {
  @override
  State<CoreMaps> createState() => CoreMapsState();
}

class CoreMapsState extends State<CoreMaps> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<InputController>(context);
    modalToggle() {
      if (provider.where != null && provider.from != null) {
        return FloatingActionButton.extended(
            onPressed: () {
              provider.where = null;
              provider.notifyListeners();
            },
            label: Text("new Route"));
      }
      return null;
    }

    return SafeArea(
        child: new Scaffold(
      body: Stack(
        children: [
          GMap(),
          InputsModal(screenSize: MediaQuery.of(context).size),
        ],
      ),
      floatingActionButton: modalToggle(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
