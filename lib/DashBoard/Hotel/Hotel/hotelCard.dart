// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HotelDetails.dart';

class HotelCard extends StatefulWidget {
  Hotel hotel;

  HotelCard({this.hotel});

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.hotel.hotelName != null
        ? GestureDetector(
            onTap: () => Get.to(HotelDetails(
              hotel: widget.hotel,
            )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                height: size.height * .4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(  borderRadius: BorderRadius.circular(8.0),child: Image.asset('images/hotels.jpg',fit: BoxFit.fitHeight,height: size.height*.5,)),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(alignment: Alignment.bottomLeft,
                          child: Text(widget.hotel.hotelName,style: GoogleFonts.headlandOne(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 20,textStyle: TextStyle(color: Colors.white))),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(alignment: Alignment.bottomRight,
                          child: RichText(
                            text: TextSpan(
                              text: widget.hotel.address ,
                                style: GoogleFonts.headlandOne(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    textStyle: TextStyle(color: Colors.white60)),
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.location_on_outlined,color: Colors.white60,)
                                ),
                                TextSpan(text: "\n"+widget.hotel.mobileNumber),
                                WidgetSpan(
                                    child: Icon(Icons.phone_android,color: Colors.white70,)
                                ),
                              ]
                            ),

                          )
                        ),
                      ),

                      Positioned(
                        right: 0,
                        top: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              // width: 80,
                              height:40,
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white70,
                              ),
                              child: Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children: [
                                    Text('Food available now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(width: 6),
                                    Icon(Icons.check_circle, color: Colors.green.withOpacity(1))
                                  ])),
                        ),
                      ),
                      // ListTile(
                      //   isThreeLine: true,
                      //   dense: true,
                      //   title: Text(
                      //     widget.hotel.hotelName,
                      //     maxLines: 2,
                      //     style: TextStyle(
                      //       fontSize: 20.0,
                      //       fontWeight: FontWeight.bold,
                      //       letterSpacing: 1.0,
                      //       color: Colors.black87,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     widget.hotel.address,
                      //     style: TextStyle(
                      //       fontFamily: 'Roboto',
                      //       color: Colors.black,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.normal,
                      //     ),
                      //   ),
                      //   leading:CircleAvatar(
                      //     backgroundColor: Colors.orangeAccent,
                      //     backgroundImage: AssetImage('images/hotels.jpg'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
