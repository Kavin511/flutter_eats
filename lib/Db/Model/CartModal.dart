import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Model/MenuModal.dart';

class CartModel {
  Hotel hotel;
  Menu menu;
  int count;
  CartModel({this.hotel, this.menu,this.count});
}
