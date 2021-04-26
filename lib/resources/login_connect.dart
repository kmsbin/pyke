import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pi_mobile/utils.dart';
import 'package:pi_mobile/model/user_model.dart';

class LoginConnect {
  static const String baseUrl = "https://pi-backend.herokuapp.com/login/";

  static connect(UserModel userModel) async {
    Response response = Response();
    try {
      Dio dio = new Dio();
      response = await dio.post(baseUrl, data: {"id": 0, "name": userModel.name, "email": userModel.email, "password": userModel.password});

      // print(response.data.keys.contains('error'));

      if (response.data.keys.contains('error')) {
        print(response.data.keys.runtimeType);
        // response.statusCode = 400;
        throw response.data['error']['message'];
        // return ;
      }
      return response;
    } on DioError catch (e) {
      return e;
    }
  }
}
