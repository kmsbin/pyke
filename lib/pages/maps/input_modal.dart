import 'package:flutter/material.dart';
import 'package:pi_mobile/pages/maps/controller/map_screen_controller.dart';
import 'package:provider/provider.dart';

class InputsModal extends StatefulWidget {
  Size screenSize;
  final String routeType;

  InputsModal({this.screenSize, this.routeType}) : super();

  @override
  _InputsModalState createState() => _InputsModalState();
}

class _InputsModalState extends State<InputsModal> {
  final _formKey = GlobalKey<FormState>();
  MapScreenController provider;

  @override
  void initState() {
    super.initState();
  }

  Widget containerList = Container();

  Widget listAdress(MapScreenController inpt) {
    return Container(
      color: Colors.black87.withOpacity(0.5),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: inpt.getLocations().length,
        itemBuilder: (BuildContext context, int index) {
          // print(inpt.getLocations());
          return Text("kasd");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MapScreenController>(context);
    print(widget.routeType);
    provider.routeType = widget.routeType;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Consumer(
                  builder: (ctxt, MapScreenController inputController, child) {
                // print(
                //     "where runtime type ------- ${inputController.where.runtimeType}");
                // print(
                //     "from runtime type ------- ${inputController.from.runtimeType}");

                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: widget.screenSize.height / 4,
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
                                      style: TextStyle(color: Colors.white54),
                                      controller:
                                          inputController.fromController,
                                      onChanged: (txt) {
                                        if (inputController.isInputFrom) {
                                          inputController.isInputFrom = false;
                                          return;
                                        }
                                        inputController.setFrom(txt);
                                      },
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
                                      style: TextStyle(color: Colors.white54),
                                      controller:
                                          inputController.whereController,
                                      onChanged: (text) {
                                        inputController.setWhere(text);
                                        // inputController.currentLocationsModifier = inputController.whereController;
                                      },
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
                          child: inputController.getLocations().isNotEmpty
                              ? Container(
                                  height: widget.screenSize.height / 7 * 3,
                                  decoration: BoxDecoration(
                                      color: Colors.black87.withOpacity(0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              widget.screenSize.height *
                                                  0.05))),
                                  padding: EdgeInsets.all(
                                      widget.screenSize.height * 0.05),
                                  child: ListView.builder(
                                      addRepaintBoundaries: true,
                                      itemCount:
                                          inputController.getLocations().length,
                                      itemBuilder: (ctxt, index) {
                                        return new ListTile(
                                            onTap: () {
                                              inputController.onSelectedItem(
                                                  index, context);
                                            },
                                            title: Text(
                                              inputController
                                                  .getLocations()[index]
                                                  .addressLine,
                                              style: TextStyle(
                                                color: Colors.white54,
                                              ),
                                            ));
                                      }),
                                )
                              : Container())
                    ]);
              }))),
    );
  }
}
