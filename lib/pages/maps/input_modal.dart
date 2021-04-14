import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pi_mobile/app_module.dart';
import 'package:pi_mobile/blocs/directions/directions_bloc.dart';
import 'package:pi_mobile/blocs/modal_location_bloc.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:pi_mobile/utils.dart';

class InputsModal extends StatefulWidget {
  final Size screenSize;
  final String routeType;
  final BuildContext modalCtxt;

  InputsModal({this.screenSize, this.routeType, @required this.modalCtxt}) : super();

  @override
  _InputsModalState createState() => _InputsModalState();
}

class _InputsModalState extends State<InputsModal> {
  final _formKey = GlobalKey<FormState>();
  ModalLocationBloc _modalController = AppModule.to.bloc<ModalLocationBloc>();
  @override
  void initState() {
    AppModule.to.bloc<DirectionsBloc>().stream();
    () async {
      AppModule.to.bloc<DirectionsBloc>().modalContext = widget.modalCtxt;
      String address = await Utils.getAddressFromCoord(Utils.position);
      Position position = await Utils.position;

      AppModule.to.bloc<ModalLocationBloc>().initialPosition(LatLng(position.latitude, position.longitude), address);
    }();

    // Utils.position.then((Position position) async {
    //   AppModule.to.bloc<ModalLocationBloc>().initialPosition(LatLng(position.latitude, position.longitude), address.first.addressLine);
    //   Geocoder.local.findAddressesFromCoordinates(Coordinates(position.latitude, position.longitude)).then((address) {});

    //   // print("\n\n rua: ${place.street}, bairro: ${place.subLocality}  \n\n\n");
    //   // print("\n\n lat ${position.latitude}, lng: ${position.longitude}  \n\n\n");
    // });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.routeType);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Container(
                      height: screenSize.height / 3.2,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(color: Colors.black87.withOpacity(0.5), borderRadius: BorderRadius.all(Radius.circular(screenSize.height * 0.05))),
                      padding: EdgeInsets.all(screenSize.height * 0.03),
                      child: Form(
                          onChanged: () {},
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                        controller: _modalController.fromTextController,
                                        style: TextStyle(color: Colors.white54),
                                        onChanged: (String data) {
                                          AppModule.to.bloc<ModalLocationBloc>().displayTextValue(data, InputModifier.from);
                                        },
                                        // onChanged: (txt) =>
                                        // inputController.setFrom(txt)
                                        // ,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(color: Colors.white54),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white54, width: 2.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white54, width: 2.0),
                                            ))),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      AppModule.to.bloc<ModalLocationBloc>().clearInput(InputModifier.from);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white54,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                        controller: _modalController.toTextController,
                                        style: TextStyle(color: Colors.white54),
                                        onChanged: (String data) {
                                          AppModule.to.bloc<ModalLocationBloc>().displayTextValue(data, InputModifier.to);
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white54, width: 2.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white54, width: 2.0),
                                            ))),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        AppModule.to.bloc<ModalLocationBloc>().clearInput(InputModifier.to);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white54,
                                      ))
                                ],
                              )
                            ],
                          ))),
                  Expanded(
                      child: Container(
                    height: screenSize.height / 7 * 3,
                    decoration: BoxDecoration(color: Colors.black87.withOpacity(0.5), borderRadius: BorderRadius.all(Radius.circular(screenSize.height * 0.05))),
                    padding: EdgeInsets.all(screenSize.height * 0.05),
                    child: StreamBuilder(
                        stream: _modalController.output,
                        initialData: ModalLocationBloc(),
                        builder: (context, snapshot) => ListView.builder(
                            addRepaintBoundaries: true,
                            itemCount: snapshot.data?.locations?.length,
                            itemBuilder: (ctxt, index) => ListTile(
                                onTap: () => _modalController.onSelectedItem(index),
                                title: Text(
                                  _modalController?.locations[index]?.placeName,
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                )))),
                  )
                      //         : Container())
                      )
                ]))));
  }
}
