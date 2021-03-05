import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Networking/HotelNetworking/HotelApiHelper.dart';
class HotelRepository {
  HotelApiHelper _helper = HotelApiHelper();
  Future<List<Hotel>> getHotel() async {
    final response = await _helper.get('/getHotels');
    print(response);
    return HotelResponse.fromJson(response).hotel;
  }
}