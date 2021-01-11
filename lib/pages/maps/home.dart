import 'package:flutter/material.dart';
import 'package:pi_mobile/custom_icons.dart';
import 'package:pi_mobile/pages/maps/gmap.dart';
import 'package:pi_mobile/pages/maps/input_modal.dart';
import 'package:pi_mobile/utils.dart';

class CoreMaps extends StatefulWidget {
  @override
  State<CoreMaps> createState() => CoreMapsState();
}

class CoreMapsState extends State<CoreMaps> with TickerProviderStateMixin {
  List<Animation<Offset>> navOffset = new List<Animation<Offset>>();
  Animation colorButton;
  AnimationController _controller;
  bool isRun = false;

  double iconDistance = -3;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    navOffset.length = 3;
    for (int index = 0; index < 3; index++) {
      navOffset[index] =
          Tween<Offset>(begin: Offset.zero, end: Offset(0, iconDistance))
              .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ));
      colorButton = ColorTween(begin: Color(0xffD31B77), end: Colors.red[800])
          .animate(_controller);
      iconDistance = iconDistance - 1.5;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    modalToggle() {
      return Stack(children: <Widget>[
        Align(
            alignment: Alignment.bottomRight,
            child: SlideTransition(
              position: navOffset[0],
              child: FloatingActionButton(
                  heroTag: "awserhwgwegwerh",
                  child: Icon(Icons.search),
                  onPressed: () {
                    isRun = !isRun;
                    if (isRun) {
                      _controller.forward();
                      // isRun = false;
                      return;
                    }

                    showGeneralDialog(
                        context: context,
                        pageBuilder: (BuildContext ctxt, asd, dfsg) {
                          return InputsModal(
                              screenSize: MediaQuery.of(ctxt).size);
                        });
                    _controller.reverse();
                  }),
            )),
        Align(
            alignment: Alignment.bottomRight,
            child: SlideTransition(
              position: navOffset[1],
              child: FloatingActionButton(
                  heroTag: "asdgaehadgtxedcrfect",
                  child: Icon(Icons.directions_bike),
                  onPressed: () {
                    isRun = !isRun;
                    if (isRun) {
                      _controller.forward();
                      return;
                    }
                    _controller.reverse();
                  }),
            )),
        Align(
            alignment: Alignment.bottomRight,
            child: SlideTransition(
              position: navOffset[2],
              child: FloatingActionButton(
                  heroTag: "@#ahgdsaëaerha4wgrafhadfsyhwasdh#sd#ha%h",
                  child: Icon(FastBike.bike_fast_icon_135885),
                  onPressed: () {
                    isRun = !isRun;
                    if (isRun) {
                      _controller.forward();
                      return;
                    }
                    _controller.reverse();
                  }),
            )),
        Align(
            alignment: Alignment.bottomRight,
            child: AnimatedBuilder(
                animation: colorButton,
                builder: (context, widget) {
                  return FloatingActionButton(
                      mini: false,
                      backgroundColor: colorButton.value,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _controller,
                      ),
                      heroTag: "asdg#ssehja2345%rh",
                      onPressed: () {
                        isRun = !isRun;
                        if (isRun) {
                          _controller.forward();
                          // isRun = false;
                          return;
                        }
                        _controller.reverse();
                      });
                }))
      ]);
    }

    return SafeArea(
        child: new Scaffold(
      body: Stack(
        children: [
          GMap(),
        ],
      ),
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
                    Container(
                      height: MediaQuery.of(context).size.height * .33,
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
      floatingActionButton: modalToggle(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
