// import 'dart:html';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'HotelDetails.dart';

class HotelCard extends StatelessWidget {
  Hotel hotel;

  HotelCard({this.hotel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: kMainColor,
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: const Color(0xf5f5f5),
            border: Border.all(width: 1, color: Color(0xffcecece)),
            borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.only(top: kDefaultPadding / 2),
        child: GestureDetector(
          onTap: () => Get.to(HotelDetails(
            hotel: hotel,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  child: Image.asset(
                    'images/hotels.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: kDefaultPadding / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8),
                      child: Icon(CupertinoIcons.building_2_fill),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8),
                      child: Text(
                        hotel.hotelName,
                        style: TextStyle(color: kTextColor),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: kDefaultPadding / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.location_solid),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        hotel.address,
                        style:
                            TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
