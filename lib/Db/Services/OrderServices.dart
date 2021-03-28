import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/CartArgument.dart';
import 'package:flutter_eats/Db/Model/CartModal.dart';
import 'package:flutter_eats/Db/Services/jwt_decoder.dart';
import 'package:flutter_eats/LocalStorage/Cart.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  Dio dio = new Dio();
  String base_URL = "https://fluttereats.herokuapp.com/flutterEats";
  placeOrder(CartArgument cartArgument) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String yourToken = prefs.getString('token');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    var map = "";
    // var item=jsonEncode(cart);
    // print(item);
    List jsonList = cartArgument.cart.map((e) => e.toJson()).toList();
    print(jsonList);

    print(map);
    var number = decodedToken['mobileNumber'].toString();
    try {
      return await dio.patch(base_URL + "/placeorder",
          data: {
            "mobileNumber": number,
            "restaurantMobileNumber": cartArgument.hotel.mobileNumber,
            "orderItems": jsonList,
            "pincode": "2323433",
            "state": "tN",
            "district": "aszx",
            "address": "szxcxbnm",
          },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          onSendProgress: (send, total) => {
                send < total
                    ? Get.snackbar('Placing order!',
                        '${cartArgument.cart.length} items in your order',
                        snackPosition: SnackPosition.BOTTOM,
                        padding: EdgeInsets.all(kDefaultPadding),
                        margin: EdgeInsets.all(kDefaultPadding),
                        showProgressIndicator: true,
                        isDismissible: false,
                        shouldIconPulse: true,
                        icon: Icon(
                          Icons.food_bank_outlined,
                          color: kAccentColor,
                        ),
                        forwardAnimationCurve: Curves.easeOutBack,
                        reverseAnimationCurve: Curves.slowMiddle,
                        duration:
                            const Duration(seconds: Duration.secondsPerDay))
                    : Get.snackbar(
                        'Order placed successfully!',
                        'Ordered  ${cartArgument.cart.length} items !',
                        snackPosition: SnackPosition.BOTTOM,
                        padding: EdgeInsets.all(kDefaultPadding),
                        margin: EdgeInsets.all(kDefaultPadding),
                        isDismissible: false,
                        shouldIconPulse: true,
                        icon: Icon(
                          Icons.check_circle,
                          color: kAccentColor,
                        ),
                        forwardAnimationCurve: Curves.easeOutBack,
                        reverseAnimationCurve: Curves.slowMiddle,
                      )
              });
    } on DioError catch (e) {
      Get.snackbar(e.toString(), "message");
    }
  }
}
