import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/menuList.dart';
import 'package:flutter_eats/Db/Model/FoodModal.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Networking/MenuNetworking/MenuResponse.dart';
import 'package:flutter_eats/Db/bloc/MenuBloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelDetails extends StatefulWidget {
  Hotel hotel;

  HotelDetails({this.hotel});

  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  List<Food> food = [];

  MenuBloc menuBloc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget cartView() => Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.redAccent.withOpacity(.9),
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
        );

    Widget appbar = AppBar(
      centerTitle: true,
      title: Text(widget.hotel.hotelName),
    );
    Widget hotelImage() => Container(
          height: size.height * .4,
          color: Colors.white,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            width: size.width,
            height: size.height * .5 - 25,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0)),
              image: new DecorationImage(
                  image: AssetImage('images/hotels.jpg'), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black26.withOpacity(.5),
                ),
              ],
            ),
          ),
        );
    Widget expandable() => Card(
          child: ExpandablePanel(
            header: RichText(
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
            expanded: Column(
              children: [
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
            collapsed: null,
          ),
        );
    return Scaffold(
        appBar: appbar,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * .1),
                child: Column(
                  children: [
                    hotelImage(),
                    expandable(),
                    Card(
                      child: SizedBox(
                        height: 250,
                        width: size.width*.9,
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
                                          Text('Getting menus from this hotel')
                                        ],
                                      ),
                                    );
                                    break;
                                  case Status.COMPLETED:
                                    print('completed');
                                    return MenuList(
                                        menuData: snapshot.data.data,
                                        hotelData: widget.hotel);
                                    break;
                                  case Status.ERROR:
                                    print('error do');
                                    return new Container(
                                      child: Center(
                                          child: Text(
                                              'No menu items availabel ,try after some time')),
                                    );
                                    break;
                                }
                              }
                              return Container();
                            }),
                      ),
                    ),
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
