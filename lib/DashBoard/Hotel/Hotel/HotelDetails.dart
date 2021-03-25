import 'dart:convert';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/CartNotifier.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/Menucard.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/menuList.dart';
import 'package:flutter_eats/DashBoard/Orders.dart';
import 'package:flutter_eats/Db/Model/CartModal.dart';
import 'package:flutter_eats/Db/Model/FoodModal.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Model/MenuModal.dart';
import 'package:flutter_eats/Db/Networking/MenuNetworking/MenuResponse.dart';
import 'package:flutter_eats/Db/bloc/MenuBloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HotelDetails extends StatefulWidget {
  Hotel hotel;
  HotelDetails({this.hotel});
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  List<CartModel> cart;
  MenuBloc menuBloc;
  addedToCart(Menu menu){
   // if(cart.)
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget cartView() => Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(
                left: size.width * .05, right: size.width * .05, bottom: .05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.redAccent.withOpacity(.99),
            ),
            width: size.width * .95,
            child: Provider(
              create: (_) => CartNotifier(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Proceed to Buy',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        );
    Widget appbar = AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.hotel.hotelName,
        style: TextStyle(color: Colors.white),
      ),
    );
    Widget hotelImage() => Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            elevation: 4,
            child: Container(
              height: size.height * .4,
              width: size.width * .95,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                width: size.width,
                height: size.height * .5 - 50,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(7.0),
                      topRight: Radius.circular(7.0),
                      bottomLeft: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0)),
                  image: new DecorationImage(
                      image: AssetImage('images/hotels.jpg'),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26.withOpacity(.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
    Widget hotelInfo() => Card(
          elevation: 4,
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
    Widget menuCard(Menu menu) =>  new InkWell(
      onTap: (){print("tapped");},
      child: new Container(
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
                        child: Text(menu.foodName),
                      ),
                      Icon(Icons.restaurant)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(menu.price),
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
                        print(menu.id_);
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
                      child: !true
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
                      color: !true
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

    Widget menuList() => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4,
          child: SizedBox(
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
                            : Row(
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
                              );
                        break;
                      case Status.ERROR:
                        return new Container(
                          child: Center(
                              child: Row(
                            children: [
                              Icon(
                                Icons.no_food,
                                size: 40,
                              ),
                              Text(
                                  'No menu items available ,try after some time'),
                            ],
                          )),
                        );
                        break;
                    }
                  }
                  return Container();
                }),
          ),
        );
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFAFA),
        appBar: appbar,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * .1, top: .1),
                child: Column(
                  children: [
                    hotelImage(),
                    hotelInfo(),
                    menuList(),
                  ],
                ),
              ),
            ),
            cartView(),
          ],
        ));
  }

  @override
  void initState() {
    menuBloc = MenuBloc();
    menuBloc.fetchMenu(widget.hotel.mobileNumber);
  }
}
