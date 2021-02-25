import 'package:flutter_eats/Db/Model/LoginModel.dart';
import 'package:flutter_eats/Db/Networking/AuthNetworking/LoginAuthApiHelper.dart';
class LoginRepository {
  LoginApiHelper _helper = LoginApiHelper();

  loginUser(Login login) async {
    final response = await _helper.post(login);
    print(response);
    return response;
  }
}
