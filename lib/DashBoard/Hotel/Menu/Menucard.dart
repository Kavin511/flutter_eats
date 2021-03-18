import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Model/MenuModal.dart';
import 'package:flutter_eats/LocalStorage/Cart.dart';

class MenuCard extends StatefulWidget {
  Menu menu;
  Hotel hotel;

  MenuCard({this.menu, this.hotel});

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  final CartStorage cartStorage = CartStorage();
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black12.withOpacity(.1),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent.withOpacity(.1),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/food.jpg'),
                radius: 50,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(widget.menu.foodName),
                ),
                Icon(Icons.restaurant)
              ],
            ),
            Row(
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
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                onPressed: () {
                  if (!addedToCart) {
                    final cart = json.encode({
                      "foodName": widget.menu.foodName,
                      "foodType": widget.menu.foodType,
                      "foodPrice": widget.menu.price,
                      "foodDesc": widget.menu.foodDesc,
                      "category": widget.menu.category,
                      "availability": widget.menu.availability,
                      "hotelNumber":widget.hotel.mobileNumber,
                      "hotelName":widget.hotel.hotelName,
                    });
                    setState(() {
                      addedToCart = true;
                    });
                    addToCart(cart);
                  }
                },
                child: !addedToCart
                    ? Text('Add to Basket')
                    : Text('Added to Cart'),
                color: !addedToCart
                    ? Colors.green.withGreen(10)
                    : Colors.green.withGreen(10).withOpacity(.1),
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  void addToCart(String cart) {
    List cartList = cartStorage.getCart() != null ? cartStorage.getCart() : [];
    cartList.add(cart);
    cartStorage.addToCart(cartList);
    final snackBar =
        SnackBar(content: Text('Menu Added to Cart successfully!'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
