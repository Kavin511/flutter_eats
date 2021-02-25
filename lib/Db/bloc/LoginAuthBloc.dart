import 'dart:async';

import 'package:flutter_eats/Db/Model/LoginModel.dart';
import 'package:flutter_eats/Db/Networking/AuthNetworking/LoginAuthResponse.dart';
import 'package:flutter_eats/Db/Repository/LoginRepository.dart';

class LoginBloc {
  LoginRepository _loginRepository;
  StreamController _controller;
  Login login;

  StreamSink<LoginApiResponse<Login>> get LoginListSink => _controller.sink;

  LoginBloc(Login data) {
    this.login = data;
    _controller = StreamController<LoginApiResponse<Login>>();
    _loginRepository = LoginRepository();
    doLogin(login);
  }

  doLogin(Login login) async {
    LoginListSink.add(LoginApiResponse.authenticating('Authenticating user'));
    try {
      await _loginRepository.loginUser(login);
      LoginListSink.add(LoginApiResponse.completed('Logged in'));
    } catch (e) {
      LoginListSink.add(LoginApiResponse.error('Error occurred'));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
  }
}
