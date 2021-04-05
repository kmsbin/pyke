import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pi_mobile/blocs/modal_location_bloc.dart';
import 'package:pi_mobile/controller/map_screen_controller.dart';
import 'package:pi_mobile/model/modal_location_model.dart';
import 'package:pi_mobile/utils.dart';
import 'package:provider/provider.dart';

class InputsModal extends StatefulWidget {
  final Size screenSize;
  final String routeType;

  InputsModal({this.screenSize, this.routeType}) : super();

  @override
  _InputsModalState createState() => _InputsModalState();
}

class _InputsModalState extends State<InputsModal> {
  final _formKey = GlobalKey<FormState>();
  ModalLocationBloc _modalController = ModalLocationBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _modalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<MapScreenController>(context);
    print(widget.routeType);
    // provider.routeType = widget.routeType;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: widget.screenSize.height / 3.2,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.black87.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  widget.screenSize.height * 0.05))),
                          padding:
                              EdgeInsets.all(widget.screenSize.height * 0.05),
                          child: Form(
                              onChanged: () {},
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  TextFormField(
                                      controller:
                                          _modalController.fromTextController,
                                      style: TextStyle(color: Colors.white54),
                                      onChanged: (String data) {
                                        _modalController.displayTextValue(
                                            data, InputModifier.from);
                                      },
                                      // onChanged: (txt) =>
                                      // inputController.setFrom(txt)
                                      // ,
                                      decoration: InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.white54),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54,
                                                width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54,
                                                width: 2.0),
                                          ))),
                                  TextFormField(
                                      controller:
                                          _modalController.toTextController,
                                      style: TextStyle(color: Colors.white54),
                                      onChanged: (String data) {
                                        _modalController.displayTextValue(
                                            data, InputModifier.to);
                                      },
                                      // controller:
                                      //     inputController.whereController,
                                      // onChanged: (text) {
                                      //   inputController.setWhere(text);
                                      //   // inputController.currentLocationsModifier = inputController.whereController;
                                      // },
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54,
                                                width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54,
                                                width: 2.0),
                                          )))
                                ],
                              ))),
                      Expanded(
                          child: Container(
                        height: widget.screenSize.height / 7 * 3,
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(
                                widget.screenSize.height * 0.05))),
                        padding:
                            EdgeInsets.all(widget.screenSize.height * 0.05),
                        child: StreamBuilder(
                            stream: _modalController?.output,
                            initialData: ListTile(
                                title: Text(
                              'Nenhuma localização ',
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            )),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                  addRepaintBoundaries: true,
                                  itemCount: _modalController.locations?.length,
                                  itemBuilder: (ctxt, index) {
                                    return new ListTile(
                                        onTap: _modalController.onSelectedItem,
                                        title: Text(
                                          _modalController
                                              .locations[index]?.placeName,
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ));
                                  });
                            }),
                      )
                          //         : Container())
                          )
                    ]))));
  }
}
