import 'package:flutter_eats/Db/Model/OrderModal.dart';
import 'package:flutter_eats/Db/Networking/OrderNetworking/OrderApiHelper.dart';
import 'package:flutter_eats/Db/Services/jwt_decoder.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  OrderApiHelper _helper = OrderApiHelper();

  Future<List<OrderModal>> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String yourToken = prefs.getString('token');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    var number = decodedToken['mobileNumber'].toString();
    final response = await _helper.get('/getOrderDetails/${number}');
    print(response);
    return OrderResponse.fromJson(response).order;
  }
}
