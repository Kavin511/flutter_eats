import 'dart:convert';

// import 'dart:js';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/CartNotifier.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/Menucard.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/menuList.dart';
import 'file:///D:/C%20files/AndroidStudioProjects/flutter_eats/lib/DashBoard/Orders/Orders.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/CartArgument.dart';
import 'package:flutter_eats/Db/Model/CartModal.dart';
import 'package:flutter_eats/Db/Model/FoodModal.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Model/MenuModal.dart';
import 'package:flutter_eats/Db/Networking/MenuNetworking/MenuResponse.dart';
import 'package:flutter_eats/Db/bloc/MenuBloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetails extends StatefulWidget {
  Hotel hotel;

  HotelDetails({this.hotel});

  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  List<CartModel> cart = [];
  MenuBloc menuBloc;
  bool marked = false;

  @override
  void initState() {
    menuBloc = MenuBloc();
    menuBloc.fetchMenu(widget.hotel.mobileNumber);
  }

  addedToCart(Menu menu) {
    setState(() {
      CartModel cartModel = new CartModel(menu: menu, count: 1);
      cart.add(cartModel);
    });
  }

  int checkInCart(String id) {
    if (cart == null) return 0;
    for (CartModel i in cart) {
      if (i.menu.id_ == id) return i.count;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget cartView() => GestureDetector(
          onTap: () => {
            // Alert(
            //   context: context,
            //   type: AlertType.warning,
            //   title: "Are you sure to order?",
            //   desc: "Totally ${cart.length} items in cart",
            //   buttons: [
            //     DialogButton(
            //       color: kAccentColor,
            //       child: Text(
            //         "Cancel",
            //         style: TextStyle(color: Colors.white, fontSize: 16),
            //       ),
            //       onPressed: () => Navigator.pop(context),
            //     ),
            //     DialogButton(
            //       color: kPrimaryColor,
            //       child: Text(
            //         "Order",
            //         style: TextStyle(color: Colors.white, fontSize: 16),
            //       ),
            //       onPressed: () => {
            //       },
            //     )
            //   ],
            // ).show(),
            Get.toNamed('/placeOrder',
                arguments: CartArgument(hotel: widget.hotel, cart: cart))
          },
          child: Hero(
            tag: 'menuCard',
            child: Container(
              margin: EdgeInsets.only(bottom: .05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kPrimaryColor,
              ),
              width: size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    'BUY NOW',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        );
    // Widget appbar =
    Widget hotelImage() => Center(
          child: Container(
            height: size.height * .4,
            width: size.width,
            color: Colors.white,
            child: Hero(
              tag: '${widget.hotel.mobileNumber}',
              child: Container(
                width: size.width,
                height: size.height * .5 - 50,
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(
                        'images/hotels.jpg',
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
    Widget hotelInfo() => Card(
          // elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: size.width * .95,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: widget.hotel.hotelName,
                            style: GoogleFonts.chelseaMarket(
                                textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )))
                      ]),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: widget.hotel.address,
                                style: GoogleFonts.playfairDisplay(
                                    textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                )))
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: widget.hotel.mobileNumber,
                              style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )))
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
    Widget menuCard(Menu menu) => InkWell(
          onTap: () {},
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 4),
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
                border: 1,
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/food.jpg'),
                            radius: 50,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8),
                                  child: Text(
                                    menu.foodName,
                                    style: TextStyle(
                                        color: kTextColor, fontSize: 16),
                                  ),
                                ),
                                Icon(
                                  Icons.restaurant,
                                  color: kTextColor,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Text(
                                    menu.price,
                                    style: TextStyle(
                                        color: kTextColor, fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Icon(
                                    Icons.attach_money_rounded,
                                    color: kTextColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          onPressed: () {
                            addedToCart(menu);
                            // if (!addedToCart) {
                            //   final cart = json.encode({
                            //     "_id": menu.id_,
                            //     "foodName": menu.foodName,
                            //     "foodType": menu.foodType,
                            //     "foodPrice": menu.price,
                            //     "foodDesc": menu.foodDesc,
                            //     "category": menu.category,
                            //     "availability": menu.availability,
                            //     "hotelNumber": widget.hotel.mobileNumber,
                            //     "hotelName":widget.hotel.hotelName,
                            //   });
                            //   setState(() {
                            //     // addedToCart = true;
                            //   });
                            //   // addToCart(cart);
                            // }
                          },
                          child: checkInCart(menu.id_) <= 0
                              ? Center(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        CupertinoIcons.add,
                                      ),
                                      onPressed: () => {addedToCart(menu)},
                                    )
                                  ],
                                ))
                              : Center(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(CupertinoIcons.minus),
                                      onPressed: () {
                                        try {
                                          for (CartModel i in cart) {
                                            if (i.menu.id_ == menu.id_) {
                                              setState(() {
                                                i.count--;
                                                if (i.count <= 0) {
                                                  cart.remove(i);
                                                }
                                              });
                                            }
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                    ),
                                    Text(
                                        '${checkInCart(menu.id_).toString().padLeft(2, "0")}'),
                                    IconButton(
                                      icon: Icon(CupertinoIcons.add),
                                      onPressed: () {
                                        for (CartModel i in cart) {
                                          if (i.menu.id_ == menu.id_) {
                                            setState(() {
                                              i.count++;
                                            });
                                          }
                                        }
                                      },
                                    )
                                  ],
                                )),
                          color: checkInCart(menu.id_) <= 0
                              ? kPrimaryColor
                              : kAccentColor,
                          textColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
    Widget menuList() => SizedBox(
          height: 250,
          width: size.width * .95,
          child: StreamBuilder<MenuApiResponse>(
              stream: menuBloc.menuListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      print('loading');
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('Loading Menu items...')
                          ],
                        ),
                      );
                      break;
                    case Status.COMPLETED:
                      return snapshot.data.data.length > 0
                          ? Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (context, index) =>
                                      menuCard(snapshot.data.data[index])),
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.no_food,
                                    size: 20,
                                  ),
                                  Text(
                                    'Menu not found',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            );
                      break;
                    case Status.ERROR:
                      return new Container(
                        child: Center(
                            child: Row(
                          children: [
                            Icon(
                              Icons.no_food,
                              size: 20,
                            ),
                            Text('Menu not found'),
                          ],
                        )),
                      );
                      break;
                  }
                }
                return Container();
              }),
        );
    return Scaffold(
        backgroundColor: kAccentColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Order food',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(bottom: size.height * .1,),
                      child: Stack(
                        children: [
                          Positioned(
                            child: hotelImage(),
                            top: 0,
                            left: 0,
                            right: 0,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: size.height * .35, bottom: 0),
                            padding: EdgeInsets.only(
                                top: size.height * .05,
                                left: kDefaultPadding,
                                right: kDefaultPadding),
                            height: size.height,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.hotel.hotelName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                              color: kTextColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      iconSize: 40,
                                      icon: Image.asset(
                                        'images/square.png',
                                        color: kTextColor,
                                      ),
                                      onPressed: () {
                                        showCupertinoModalBottomSheet(
                                          elevation: 20,
                                          barrierColor:
                                              Colors.black.withOpacity(.6),
                                          context: context,
                                          builder: (context) => Container(
                                              height: size.height * .2,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Material(
                                                      child: Container(
                                                    child: IconButton(
                                                      iconSize: 40,
                                                      icon: Icon(
                                                        CupertinoIcons.mail,
                                                        size: 30,
                                                        color: kTextColor,
                                                      ),
                                                      onPressed: () async {
                                                        final Uri
                                                            _emailLaunchUri =
                                                            Uri(
                                                                scheme:
                                                                    'mailto',
                                                                path: widget
                                                                    .hotel
                                                                    .email,
                                                                queryParameters: {
                                                              'subject':
                                                                  'Reg: food related queries!'
                                                            });
                                                        if (await canLaunch(
                                                            _emailLaunchUri
                                                                .toString())) {
                                                          await launch(
                                                              _emailLaunchUri
                                                                  .toString());
                                                        } else {
                                                          throw 'Could not launch $_emailLaunchUri';
                                                        }
                                                      },
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: kMainColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )),
                                                  Material(
                                                      child: Container(
                                                    child: IconButton(
                                                      iconSize: 40,
                                                      icon: Icon(
                                                        CupertinoIcons.phone,
                                                        size: 30,
                                                        color: kTextColor,
                                                      ),
                                                      onPressed: () async {
                                                        print('clicekd');
                                                        String url = 'tel:' +
                                                            widget.hotel
                                                                .mobileNumber;
                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: kMainColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )),
                                                  Material(
                                                      child: Container(
                                                    child: IconButton(
                                                      iconSize: 40,
                                                      icon: Icon(
                                                        CupertinoIcons
                                                            .location_solid,
                                                        size: 30,
                                                        color: kTextColor,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kMainColor,
                                                    ),
                                                  )),
                                                ],
                                              )),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                menuList(),
                                cart.length > 0 ? cartView() : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
