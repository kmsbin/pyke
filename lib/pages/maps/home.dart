import 'package:flutter/material.dart';
import 'package:pi_mobile/custom_icons.dart';
import 'package:pi_mobile/pages/maps/controller/map_screen_controller.dart';
import 'package:pi_mobile/pages/maps/gmap.dart';
import 'package:pi_mobile/pages/maps/input_modal.dart';
import 'package:pi_mobile/widgets/control_screen.dart';
import 'package:provider/provider.dart';

class CoreMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GMap(),
      drawer: Drawer(
        child: Container(
          color: const Color(0xff030d22),
          child: LayoutBuilder(
              key: new Key("sdga"),
              builder: (drawerContext, constraint) {
                // print(
                //     "----------- ${constraint.maxWidth} --------- ${MediaQuery.of(context).size.width}");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 6 / 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            // color: Colors.amberAccent,
                            height: constraint.maxWidth / 2,
                            width: constraint.maxWidth / 2,
                            child:
                                Image.asset("assets/images/user_profile.png"),
                          ),
                          Container(
                            child: Text(
                              "User",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "mileage",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("12KM",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Text("hours traveled",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 15,
                                      )),
                                  Text("2.3hr",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings_sharp,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text("settings account",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      )),
                                )
                              ],
                            ))
                      ],
                    )),
                  ],
                );
              }),
        ),
      ),
      floatingActionButton: ControllScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
