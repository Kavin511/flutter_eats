

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class AuthService {
  Dio dio = new Dio();
  String base_URL = "https://fluttereats.herokuapp.com/flutterEats";
  login(mobileNumber, password) async {
    try {
      return await dio.post(base_URL + "/login",
          data: {"mobileNumber": mobileNumber, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
    print(e);
    }
  }
  register(mobileNumber, password, String email) async {
    try {
      print('reg');
      return await dio.post(base_URL + "/register", data: {
        "mobileNumber": mobileNumber,
        "password": password,
        "email": email
      });
    } on DioError catch (e) {
      BuildContext context;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }


}
