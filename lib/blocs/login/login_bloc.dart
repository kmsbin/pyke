import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pi_mobile/model/user_model.dart';
import 'package:pi_mobile/resources/login_connect.dart';
import 'package:pi_mobile/utils.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc extends BlocBase {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  BehaviorSubject _controller = BehaviorSubject();
  bool validate_email = false;
  bool validate_password = false;

  UserModel userModel = UserModel();

  Sink get input => _controller.sink;
  Stream get output => _controller.stream;
  //we have fix this scrap
  void login(BuildContext loginContext, GlobalKey<NavigatorState> navigatorKey) async {
    // if (formKey.currentState.validate()) {
    //   String route = '/login';
    //   userModel.email = email.text;
    //   userModel.password = password.text;
    //   try {
    //     var loginConnect = await LoginConnect.connect(userModel);
    //     if (loginConnect is DioError) {
    //       throw 'error';
    //     }
    //     navigatorKey.currentState.pushNamed('/');

    //     // Utils.navigatorKey.currentState.pushNamed('/');
    //   } catch (e) {
    //     route = '/login';
    //     validate_email = true;
    //     validate_password = true;
    //     formKey.currentState.validate();

    //     print('wrong credentials');
    //   }
    input.add(userModel);
    // }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
