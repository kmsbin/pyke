import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pi_mobile/pages/maps/home.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  bool validate_email = false;
  bool validate_password = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff030d22),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .80,
                maxWidth: MediaQuery.of(context).size.width * .80),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "register",
                        style:
                            TextStyle(color: Color(0xffd31b77), fontSize: 70),
                      ),
                    ),
                    Column(
                      children: [
                        //name
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: nameController,
                            style: TextStyle(
                              color: const Color(0xffd31b77),
                              decorationColor: const Color(0xffd31b77),
                            ),
                            // The validator receives the text that the user has entered.
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: const Color(0xffd31b77),
                                )),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Name';
                              }
                              if (validate_email) {}
                              return null;
                            },
                          ),
                        ),
                        //emaiç
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: emailController,
                            style: TextStyle(
                              color: const Color(0xffd31b77),
                              decorationColor: const Color(0xffd31b77),
                            ),
                            // The validator receives the text that the user has entered.
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: const Color(0xffd31b77),
                                )),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (validate_email) {
                                return "wrong email";
                              }
                              return null;
                            },
                          ),
                        ),
                        //pass
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              style: TextStyle(
                                color: const Color(0xffd31b77),
                                decorationColor: const Color(0xffd31b77),
                              ),

                              // The validator receives the text that the user has entered.
                              decoration: new InputDecoration(
                                labelStyle:
                                    TextStyle(color: const Color(0xffd31b77)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                hintText: 'Password confirm',
                                hintStyle: TextStyle(
                                  color: const Color(0xffd31b77),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                }

                                return null;
                              },
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              style: TextStyle(
                                color: const Color(0xffd31b77),
                                decorationColor: const Color(0xffd31b77),
                              ),

                              // The validator receives the text that the user has entered.
                              decoration: new InputDecoration(
                                labelStyle:
                                    TextStyle(color: const Color(0xffd31b77)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffd31b77),
                                      width: 1.0),
                                ),
                                hintText: 'Password confirm',
                                hintStyle: TextStyle(
                                  color: const Color(0xffd31b77),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  return "diferent password";
                                }
                                return null;
                              },
                            )),
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Text("sign up",
                                  style: TextStyle(
                                      color: const Color(0xffd31b77))),
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
                          Response response = Response();
                          if (_formKey.currentState.validate()) {
                            try {
                              Dio dio = new Dio();
                              var response = await dio.post(
                                  "https://pi-backend.herokuapp.com/user/",
                                  data: {
                                    "id": 0,
                                    "name": nameController.text,
                                    "email": emailController.text,
                                    "password": passwordController.text
                                  });

                              if (response.data is String) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CoreMaps()));
                                return;
                              }
                            } on DioError catch (e) {
                              if (e.response.statusCode == 400) {
                                print(e.response.data.runtimeType);
                                if (e.response.data["error"]["message"] ==
                                    "this email already registered") {
                                  validate_email = true;
                                  _formKey.currentState.validate();
                                }
                              } else {
                                print(e.message);
                                print(e.request);
                              }
                            }
                          }
                        },
                        child: Text("submit"))
                  ],
                )),
          ),
        ));
  }
}
