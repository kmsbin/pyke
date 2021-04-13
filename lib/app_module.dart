import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi_mobile/blocs/directions/directions_bloc.dart';
import 'package:pi_mobile/blocs/modal_location_bloc.dart';
import 'package:pi_mobile/pages/maps/home.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => DirectionsBloc()),
        Bloc((i) => ModalLocationBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => CoreMaps();

  static Inject get to => Inject<AppModule>.of();
}
