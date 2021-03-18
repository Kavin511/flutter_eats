import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/LocalStorage/Cart.dart';

class OrderService {
  final CartStorage cartStorage = new CartStorage();
  Dio dio = new Dio();
  String base_URL = "https://fluttereats.herokuapp.com/flutterEats";
  placeOrder(mobileNumber,restaurantMobileNumber) async{
    List cartList = cartStorage.getCart() != null ? cartStorage.getCart() : [];
    try{
      return await dio.post(base_URL+"/placeOrder/$mobileNumber$restaurantMobileNumber",data: {
        cartList
      },options: Options(contentType: Headers.formUrlEncodedContentType));
    }on DioError catch(e)
    {
      BuildContext context;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
