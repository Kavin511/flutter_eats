import 'dart:convert';
import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Services/OrderServices.dart';
import 'package:flutter_eats/LocalStorage/Cart.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final CartStorage cartStorage = new CartStorage();
  bool emptyCart = false;
  List cartList;

  @override
  Widget build(BuildContext context) {
    cartList = cartStorage.getCart() != null ? cartStorage.getCart() : [];
    emptyCart = cartList.length > 0 ? true : false;
    return Scaffold(
        floatingActionButton: Container(
          width: 200,
          child: new FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              splashColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              onPressed: () {
                orderFoodFromCart();
              },
              isExtended: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Place Order'),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ],
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: !emptyCart
            ? Container(
                child: Center(
                  child: Text(
                    'No food inside cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> cart = json.decode(cartList[index]);
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) async {
                      deleteFoodFromCart(cartList[index]);
                    },
                    child: Material(
                      elevation: 5,
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            child: Icon(Icons.restaurant),
                            backgroundImage: AssetImage(
                              'images/food.jpg',
                            ),
                          ),
                          title: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    cart['hotelName'],
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(cart['foodName']),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Column(
                                children: [
                                  Text(cart['foodDesc']),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(cart['foodPrice']),
                                      Icon(Icons.attach_money_rounded)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.redAccent,
                              ),
                              onPressed: () =>
                                  (deleteFoodFromCart(cartList[index])))),
                    ),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: AlignmentDirectional.centerStart,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ));
  }

  deleteFoodFromCart(cartFood) {
    List cartList = cartStorage.getCart() != null ? cartStorage.getCart() : [];
    List finalList = [];
    for (int i = 0; i < cartList.length; i++) {
      if (cartFood != cartList[i]) finalList.add(cartList[i]);
    }
    if (finalList.length == 0) {
      setState(() {
        emptyCart = true;
      });
    }
    cartStorage.addToCart(finalList);
    final snackBar =
        SnackBar(content: Text('Food removed from cart successfully!'));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void orderFoodFromCart() {
    OrderService().placeOrder("","");

    CoolAlert.show(
      context: context,
      animType:CoolAlertAnimType.slideInUp,
      type: CoolAlertType.success,
      text: "Your order placed successfully!",
    );
  }
}
