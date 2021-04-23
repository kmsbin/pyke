import 'package:dio/dio.dart';
import 'package:pi_mobile/model/user_model.dart';

class LoginConnect {
  static const String baseUrl = "https://pi-backend.herokuapp.com/login/";

  static connect(UserModel userModel) async {
    Response response = Response();
    try {
      Dio dio = new Dio();
      var response = await dio.post("https://pi-backend.herokuapp.com/user/", data: {"id": 0, "name": userModel.name, "email": userModel.email, "password": userModel.password});
    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        if (e.response.data["error"]["message"] == "this email already registered") {}
      } else {}
    }
  }
}
