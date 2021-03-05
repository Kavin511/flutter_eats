import 'package:flutter_eats/Db/Model/MenuModal.dart';
import 'package:flutter_eats/Db/Networking/MenuNetworking/MenuApiHelper.dart';

class MenuRepository {
  ApiHelper _helper = ApiHelper();
  Future<List<Menu>> getMenu(var mobileNumber) async {
    final response = await _helper.get('/getMenu/$mobileNumber');
    print(response);
    return MenuResponse.fromJson(response).menu;
  }
}
