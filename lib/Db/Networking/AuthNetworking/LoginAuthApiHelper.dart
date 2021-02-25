import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/LoginModel.dart';
import 'package:flutter_eats/Db/Networking/AuthNetworking/LoginAuthException.dart';
import 'package:http/http.dart' as http;

class LoginApiHelper {
  String baseUrl = Constants().baseUrL;
  Dio dio = Dio();

  Future<dynamic> post(Login login) async {
    var responseJson;
    try {
      var response = await dio.post(baseUrl + '/login',
          data: {
            'mobileNumber': login.mobileNumber!=null?login.mobileNumber:"12",
            'password': login.password!=null?login.password:"12",
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      responseJson = _returnResponse(response);
    } on DioError catch (e) {
      print(e);
    }
  }

  dynamic _returnResponse(dynamic response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        throw LoginAuthException('Error occurred ${response.statusCode}');
    }
  }
}
