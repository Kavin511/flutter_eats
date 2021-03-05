import 'package:flutter/material.dart';
import 'package:flutter_eats/DashBoard/Hotel/Hotel/hotelCard.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';

class HotelList extends StatefulWidget {
  List<Hotel> hotelList;
  HotelList({this.hotelList});
  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  @override
  Widget build(BuildContext context) {
    return widget.hotelList.length > 0
        ? ListView.builder(
        itemCount: widget.hotelList.length,
        itemBuilder: (context, index) =>
            HotelCard(hotel:widget.hotelList[index]))
        : Center(
        child: Text(
          'No items found please add menu',
          style: TextStyle(fontSize: 18),
        ));
  }
}
