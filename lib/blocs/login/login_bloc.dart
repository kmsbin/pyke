import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pi_mobile/model/user_model.dart';
import 'package:pi_mobile/resources/login_connect.dart';
import 'package:rxdart/subjects.dart';

enum LoginEvent { loading, done, error, waiting }

class LoginBloc extends BlocBase {
  LoginEvent loginState = LoginEvent.waiting;
  GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  BuildContext loginContext;
  BuildContext modalCtxt;
  TextEditingController password = TextEditingController();
  BehaviorSubject _controller = BehaviorSubject();
  bool validate_email = false;
  bool validate_password = false;

  Sink get input => _controller.sink;
  Stream get output => _controller.stream;

  //we have fix this scrap
  void login(BuildContext newLoginContext, GlobalKey<NavigatorState> newNavigatorKey) async {
    UserModel userModel = UserModel();
    navigatorKey = newNavigatorKey;

    loginContext = newLoginContext;
    if (formKey.currentState.validate()) {
      userModel.email = email.text;
      userModel.password = password.text;
      loginState = LoginEvent.loading;
      input.add(userModel);
      try {
        var loginConnect = await LoginConnect.connect(userModel);
        if (loginConnect is DioError) {
          throw 'error';
        }
        loginState = LoginEvent.done;
      } catch (e) {
        validate_email = true;
        validate_password = true;
        formKey.currentState.validate();
        loginState = LoginEvent.error;

        print('wrong credentials');
      }
      input.add(userModel);
    }
  }

  onChangeInput() {
    validate_email = false;
    validate_password = false;

    input.add(validate_email);
    input.add(validate_password);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  LoginBloc() {
    output.listen((event) {
      mapEventToState(loginState);
    });
  }

  void mapEventToState(LoginEvent evt) {
    if (evt == LoginEvent.done) {
      Navigator.pop(modalCtxt);

      print('pronto pra redirecionar');

      navigatorKey.currentState.pushNamed('/');
    }
    if (evt == LoginEvent.waiting) {
      print('esperando um event ...');
    }
    if (evt == LoginEvent.error) {
      print('credenciais erradas');
      Navigator.pop(modalCtxt);
    }
    if (evt == LoginEvent.loading) {
      print('carregando...');
      showGeneralDialog(
          context: loginContext,
          pageBuilder: (ctxt, _, __) {
            modalCtxt = ctxt;
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(loginContext).size.width * 0.1, minHeight: MediaQuery.of(loginContext).size.width * 0.1),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          });
    }
  }
}
