import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi_mobile/blocs/directions/directions_bloc.dart';
import 'package:pi_mobile/blocs/modal_location_bloc.dart';
import 'package:pi_mobile/pages/maps/home.dart';
import 'package:pi_mobile/pages/maps/input_modal.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => DirectionsBloc()),
        Bloc((i) => ModalLocationBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MaterialApp(
        theme: ThemeData(
          fontFamily: 'Ubuntu Mono',
          primaryColor: const Color(0xff030d22),
          accentColor: Color(0xffD31B77),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Google Maps Demo',
        routes: {
          '/': (context) => CoreMaps(),
          '/modal-locations': (context) => InputsModal(modalCtxt: context),
        },
      );

  static Inject get to => Inject<AppModule>.of();
}
