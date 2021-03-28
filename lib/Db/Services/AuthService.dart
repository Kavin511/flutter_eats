import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AuthService {
  Dio dio = new Dio();
  String base_URL = "https://fluttereats.herokuapp.com/flutterEats";

  login(mobileNumber, password) async {
    try {
      return await dio.post(base_URL + "/login",
          data: {"mobileNumber": mobileNumber, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType),onSendProgress: (sent,total){
        if(sent!=total)
        Get.snackbar('Logging in', 'Authenticated !',showProgressIndicator: true,snackPosition: SnackPosition.BOTTOM);
        else
          Get.snackbar('Processing!', '',duration: Duration(seconds: 100),snackPosition: SnackPosition.BOTTOM);
          });
    } on DioError catch (e) {
      Get.snackbar('Error', 'Not able to login!',duration: Duration(seconds: 10),snackPosition: SnackPosition.BOTTOM);
    }
  }
  register(mobileNumber, password, String email) async {
    try {
      print('reg');
      return await dio.post(base_URL + "/register", data: {
        "mobileNumber": mobileNumber,
        "password": password,
        "email": email
      },onSendProgress: (sent,total){
        if(sent!=total)
          Get.snackbar('Registering ', 'Processing request !',showProgressIndicator: true,duration: Duration(seconds: 200),snackPosition: SnackPosition.BOTTOM);
        else
          Get.snackbar('Invalid request!', '',duration: Duration(seconds: 10),snackPosition: SnackPosition.BOTTOM);
      });
    } on DioError catch (e) {
      Get.snackbar('Error', 'Not able to register user',duration: Duration(seconds: 10),snackPosition: SnackPosition.BOTTOM);
    }
  }
}
