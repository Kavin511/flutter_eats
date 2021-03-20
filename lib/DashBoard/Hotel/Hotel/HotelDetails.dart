import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/menuList.dart';
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
  MenuBloc menuBloc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            height: size.height * .4,
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * .5 - 25,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0)),
                    image: new DecorationImage(
                        image: AssetImage('images/hotels.jpg'),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7,
                        color: Colors.black.withOpacity(.9),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10),
                  child: IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: widget.hotel.hotelName,
                                style: GoogleFonts.metrophobic(
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )))
                          ]),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Food available now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )),
                      Icon(Icons.check_circle, color: Colors.green.withOpacity(1))
                    ])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: Colors.black), children: [
                    TextSpan(
                        text: widget.hotel.address,
                        style: GoogleFonts.averiaSerifLibre(
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.black54)))
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: Colors.black), children: [
                    TextSpan(
                        text: widget.hotel.mobileNumber,
                        style: GoogleFonts.averiaSerifLibre(
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.black54)))
                  ]),
                ),
              ),
            ],
          ),
          new Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 5, left: 10, right: 10),
                      child: Text(
                        widget.hotel.address,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.lightBlueAccent.withOpacity(.2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.event_available),
                          ),
                          Text('Opened now'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.lightBlueAccent.withOpacity(.2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.mail),
                          ),
                          Text(widget.hotel.email),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.lightBlueAccent.withOpacity(.2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.smartphone),
                          ),
                          Text(widget.hotel.mobileNumber),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.lightBlueAccent.withOpacity(.2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.location_city),
                          ),
                          Text(widget.hotel.address),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8),
            child: RichText(
                text: TextSpan(
                    text: 'Menu',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    children: [
                  WidgetSpan(child: Icon(Icons.restaurant_menu))
                ])),
          ),
          SizedBox(
            height: 250,
            child: StreamBuilder<MenuApiResponse>(
                stream: menuBloc.menuListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        print('loading');
                        return new Container(
                          child: Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                Text('Getting menus from this hotel')
                              ],
                            ),
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
        ],
      ),
    ));
  }

  @override
  void initState() {
    menuBloc = MenuBloc();
    menuBloc.fetchMenu(widget.hotel.mobileNumber);
  }
}
