import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eats/DashBoard/Hotel/Hotel/HotelDetails.dart';
import 'package:flutter_eats/Db/Model/FoodModal.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Model/MenuModal.dart';
import 'package:flutter_eats/LocalStorage/Cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';

class MenuCard extends StatefulWidget {
  Menu menu;
  Hotel hotel;
  List<String> food;
  MenuCard({this.menu, this.hotel});
  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  final CartStorage cartStorage = CartStorage();
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new InkWell(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
          child: GlassmorphicContainer(
            blur: 100,
            borderRadius: 15,
            height: 250,
            borderGradient: LinearGradient(colors: [
              Colors.black26,
              Colors.black26,
              Colors.black26,
              Colors.black26,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            linearGradient: LinearGradient(colors: [
              Colors.white70,
              Colors.white24,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            // decoration: BoxDecoration(
            //     color: Colors.white70.withOpacity(.5),
            //     shape: BoxShape.rectangle,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.lightBlueAccent.withOpacity(.1),
            //         spreadRadius: 1,
            //         blurRadius: 10,
            //       ),
            //     ]),
            border: 1,
            width: 180,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/food.jpg'),
                      radius: 50,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(widget.menu.foodName),
                      ),
                      Icon(Icons.restaurant)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.menu.price),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.attach_money_rounded),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      onPressed: () {
                        print(widget.menu.id_);
                        if (!addedToCart) {
                          final cart = json.encode({
                            "_id": widget.menu.id_,
                            "foodName": widget.menu.foodName,
                            "foodType": widget.menu.foodType,
                            "foodPrice": widget.menu.price,
                            "foodDesc": widget.menu.foodDesc,
                            "category": widget.menu.category,
                            "availability": widget.menu.availability,
                            "hotelNumber": widget.hotel.mobileNumber,
                            "hotelName": widget.hotel.hotelName,
                          });
                          setState(() {
                            addedToCart = true;
                          });
                          addToCart(cart);
                        }
                      },
                      child: !addedToCart
                          ? Center(
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Add'), Icon(Icons.add)],
                            ))
                          : Center(
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Remove'), Icon(Icons.delete)],
                            )),
                      color: !addedToCart
                          ? Colors.redAccent.withOpacity(.9)
                          : Colors.redAccent.withOpacity(.5),
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addToCart(String cart) {
    // print(HotelDetails().food.add(new Food(foodName: "dcx",foodDesc: "dsc",foodPrice: "qwds")););
    // food
    //     .add(new Food(foodName: "dcx", foodDesc: "dsc", foodPrice: "qwds"));
    List<dynamic> cartList =
        cartStorage.getCart() != null ? cartStorage.getCart() : [];
    cartList.add(cart);
    cartStorage.addToCart(cartList);
    Fluttertoast.showToast(
        msg: "Item added to cart",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
