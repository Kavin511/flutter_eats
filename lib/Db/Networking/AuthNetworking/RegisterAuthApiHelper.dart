import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/RegisterModel.dart';
import 'package:http/http.dart' as http;

import 'RegisterAuthException.dart';

class RegisterApiHelper {
  String baseUrl = Constants().baseUrL;
  Dio dio = Dio();

  Future<dynamic> post(Register Register) async {
    var responseJson;
    try {
      final response = await dio.post(baseUrl + '/Register',
          data: {
            'mobileNumber': Register.mobileNumber,
            'password': Register.password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      responseJson = _returnResponse(response);
    } on DioError catch (e) {
      print(e);
    }
    return responseJson;
  }

  dynamic _returnResponse(dynamic response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        throw RegisterAuthException('Error occurred ${response.statusCode}');
    }
  }
}
