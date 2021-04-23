import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi_mobile/blocs/directions/directions_bloc.dart';
import 'package:pi_mobile/blocs/modal_location_bloc.dart';
import 'package:pi_mobile/blocs/controls_bloc.dart';
import 'package:pi_mobile/pages/login/login_home.dart';
import 'package:pi_mobile/pages/maps/home.dart';
import 'package:pi_mobile/pages/maps/input_modal.dart';
import 'package:pi_mobile/utils.dart';

import 'blocs/login/login_bloc.dart';

class AppModule extends ModuleWidget {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  List<Bloc> get blocs => [
        Bloc((i) => LoginBloc()),
        Bloc((i) => DirectionsBloc()),
        Bloc((i) => ModalLocationBloc()),
        Bloc((i) => ControlsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Ubuntu Mono',
        primaryColor: const Color(0xff030d22),
        accentColor: Color(0xffD31B77),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Pyke',
      initialRoute: '/login',
      routes: {
        '/': (context) => CoreMaps(),
        '/login': (context) => LoginScreen(navigatorKey: navigatorKey),
        '/modal-locations': (context) => InputsModal(modalCtxt: context),
      },
    );
  }

  static Inject get to => Inject<AppModule>.of();
}
