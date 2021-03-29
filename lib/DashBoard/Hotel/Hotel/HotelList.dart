import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/DashBoard/Hotel/Hotel/hotelCard.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';

class HotelList extends StatefulWidget {
  List<Hotel> hotelList;

  HotelList({this.hotelList});

  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  List<String> hotelImageUrl=["hotels_images/hotels.jpg","hotels_images/hotel1.jpg","hotels_images/hotel2.jpg","hotels_images/hotel3.jpg","hotels_images/hotel4.jpg","hotels_images/hotel5.jpg"];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding/4),
      child: widget.hotelList.length > 0
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/4),
            child: GridView.builder(
              itemCount: widget.hotelList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // mainAxisSpacing: 0,
                    crossAxisCount: 1, childAspectRatio: 1,crossAxisSpacing: 0),
                itemBuilder: (context, index) =>
                    HotelCard(hotel: widget.hotelList[index],imageUrl:hotelImageUrl[index%6])),
          )
          : Center(
              child: Text(
              'No hotels found',
              style: TextStyle(fontSize: 18),
            )),
    );
  }
}
// ListView.builder(
//
// itemCount: widget.hotelList.length,
// itemBuilder: (context, index) =>
// HotelCard(hotel:widget.hotelList[index]))
