import 'package:flutter_eats/Db/Model/CartModal.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';

class CartArgument {
  Hotel hotel;
  List<CartModel> cart;

  CartArgument({this.hotel, this.cart});
}
