import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pi_mobile/model/user_model.dart';
import 'package:pi_mobile/resources/register_connect.dart';
import 'package:rxdart/rxdart.dart';

enum RegisterEvent { loading, done, error, waiting }

class RegisterBloc extends BlocBase {
  RegisterEvent registerState = RegisterEvent.waiting;

  BehaviorSubject _controller = BehaviorSubject();

  Sink get input => _controller.sink;
  Stream get output => _controller.stream;

  GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  BuildContext registerContext;
  BuildContext modalCtxt;
  bool validate_email = false;
  bool validate_password = false;

  RegisterBloc() {
    output.listen((event) {
      mapEventToState(registerState);
    });
  }

  void registerUser(BuildContext newRegisterContext, GlobalKey<NavigatorState> newNavigatorKey) async {
    registerContext = newRegisterContext;
    navigatorKey = newNavigatorKey;
    print("i'm int the bloc");
    UserModel userModel = UserModel();
    if (formKey.currentState.validate()) {
      userModel.email = email.text;
      userModel.password = password.text;
      userModel.name = nome.text;
      registerState = RegisterEvent.loading;
      print(userModel.email);
      print(userModel.password);
      print(userModel.name);
      input.add(userModel);
      try {
        var loginConnect = await compute(RegisterConnect.connect, userModel);
        if (loginConnect is DioError) {
          throw 'error';
        }
        registerState = RegisterEvent.done;
      } catch (e) {
        formKey.currentState.validate();
        registerState = RegisterEvent.error;

        print('wrong credentials');
      }
      input.add(userModel);
    }
  }

  void mapEventToState(RegisterEvent evt) {
    if (evt == RegisterEvent.done) {
      Navigator.pop(modalCtxt);

      print('pronto pra redirecionar');

      navigatorKey.currentState.pushNamed('/');
    }
    if (evt == RegisterEvent.waiting) {
      print('esperando um event ...');
    }
    if (evt == RegisterEvent.error) {
      print('credenciais erradas');
      Navigator.pop(modalCtxt);
    }
    if (evt == RegisterEvent.loading) {
      print('carregando...');
      showGeneralDialog(
          context: registerContext,
          pageBuilder: (ctxt, _, __) {
            modalCtxt = ctxt;
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(registerContext).size.width * 0.1, minHeight: MediaQuery.of(registerContext).size.width * 0.1),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          });
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
