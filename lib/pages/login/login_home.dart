import 'package:flutter/material.dart';
import 'package:pi_mobile/app_module.dart';
import 'package:pi_mobile/blocs/login/login_bloc.dart';
import 'package:pi_mobile/pages/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<NavigatorState> navigatorKey;

  var loginBloc = AppModule.to.bloc<LoginBloc>();

  LoginScreen({this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff030d22),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .80, maxWidth: MediaQuery.of(context).size.width * .80),
            child: StreamBuilder(
                stream: AppModule.to.bloc<LoginBloc>().output,
                builder: (context, snapshot) {
                  // if (snapshot.hasData) {
                  return Form(
                      key: loginBloc.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              "Sign in",
                              style: TextStyle(color: Color(0xffd31b77), fontSize: 70),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: loginBloc.email,
                                  onChanged: (evt) {
                                    loginBloc.validate_email = false;
                                    loginBloc.formKey.currentState.validate();
                                  },
                                  style: TextStyle(
                                    color: const Color(0xffd31b77),
                                    decorationColor: const Color(0xffd31b77),
                                  ),
                                  // The validator receives the text that the user has entered.
                                  decoration: new InputDecoration(
                                      labelStyle: TextStyle(color: const Color(0xffd31b77)),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                      ),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: const Color(0xffd31b77),
                                      )),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (loginBloc.validate_email) {
                                      return "wrong email";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              TextFormField(
                                controller: loginBloc.password,
                                obscureText: true,
                                onChanged: (evt) {
                                  loginBloc.validate_password = false;
                                  loginBloc.formKey.currentState.validate();
                                },
                                style: TextStyle(
                                  color: const Color(0xffd31b77),
                                  decorationColor: const Color(0xffd31b77),
                                ),
                                // The validator receives the text that the user has entered.
                                decoration: new InputDecoration(
                                  labelStyle: TextStyle(color: const Color(0xffd31b77)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xffd31b77), width: 1.0),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: const Color(0xffd31b77),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (loginBloc.validate_password) {
                                    return "wrong password";
                                  }
                                  return null;
                                },
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                  },
                                  child: Container(
                                    child: Text("Register", style: TextStyle(color: const Color(0xffd31b77))),
                                  ))
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xffd31b77),
                                onPrimary: Colors.white,
                                shadowColor: const Color(0xffd31b77),
                                elevation: 5,
                              ),
                              // style: ButtonStyle(

                              //   backgroundColor: Color(0xffD31B77)
                              // ),
                              onPressed: () async {
                                loginBloc.login(context, navigatorKey);
                              },
                              child: Text("submit"))
                        ],
                      ));
                }),
          ),
        ));
  }
}
