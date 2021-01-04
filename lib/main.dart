import 'package:flutter/material.dart';
import 'package:pi_mobile/pages/maps/home.dart';
import 'package:pi_mobile/pages/maps/controller/input_controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<InputController>.value(
              value: InputController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Google Maps Demo',
          home: CoreMaps(),
        ));
  }
}
