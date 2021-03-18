import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:get/get.dart';

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
      onTap: ()=>Get.to(HotelDetails(hotel: widget.hotel,)),
          child: SizedBox(
              width: size.width,
              child: Card(
                elevation: 10,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ListTile(
                          isThreeLine: true,
                          dense: true,
                          title: Text(
                            widget.hotel.hotelName,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            widget.hotel.address,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          leading:CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            backgroundImage: AssetImage('images/hotels.jpg'),
                          ),
                        ),

                      ],
                    ),
                  ),

                ),
              ),
            ),
        )
        : Container();
  }
}
