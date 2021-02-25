import 'package:flutter_eats/Db/Model/RegisterModel.dart';
import 'package:flutter_eats/Db/Networking/AuthNetworking/RegisterAuthApiHelper.dart';

class RegisterRepository {
  RegisterApiHelper _helper = RegisterApiHelper();
  Register register;
  RegisterRepository({
    this.register,
  });
  registerUser() async {
    final response = await _helper.post(register);
    print(response);
    return response;
  }
}
