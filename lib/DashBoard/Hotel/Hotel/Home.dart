import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Networking/HotelNetworking/HotelResponse.dart';
import 'package:flutter_eats/Db/bloc/HotelBloc.dart';

import 'HotelList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HotelBloc hotelBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(child: StreamBuilder(stream: hotelBloc.HotelListStream,builder: (context,snapshot){
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              print('loading');
              return new Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case Status.COMPLETED:
              print('completed');
              return HotelList(hotelList:snapshot.data.data);
              break;
            case Status.ERROR:
              print('error do');
              return new Container(
                child: Center(
                    child: Text('No menu items found Add new Items...')),
              );
              break;
          }
        }
        return Container();
      }), onRefresh: (){
        return hotelBloc.fetchHotel();
      }),
    );
  }
  @override
  void initState() {
    super.initState();
    hotelBloc=HotelBloc();
  }
}
