import 'dart:async';

import 'package:flutter_eats/Db/Model/HotelModal.dart';
import 'package:flutter_eats/Db/Networking/HotelNetworking/HotelResponse.dart';
import 'package:flutter_eats/Db/Repository/HotelRepository.dart';
import 'package:flutter_eats/jwtDecoder/jwtDecoder.dart';


class HotelBloc {
  HotelRepository _HotelRepository;
  StreamController _controller;

  StreamSink<HotelApiResponse<List<Hotel>>> get HotelListSink => _controller.sink;
  Stream<HotelApiResponse<List<Hotel>>> get HotelListStream => _controller.stream;

  HotelBloc() {
    _controller = StreamController<HotelApiResponse<List<Hotel>>>();
    _HotelRepository = HotelRepository();
    fetchHotel();
  }
  refreshHotel() async{
    HotelListSink.add(HotelApiResponse.refreshing('Getting Hotel available'));
    try {
      List<Hotel> HotelList = await _HotelRepository.getHotel();
      HotelListSink.add(HotelApiResponse.completed(HotelList));
    } catch (e) {
      HotelListSink.add(HotelApiResponse.error('Error occurred'));
      print(e);
    }
  }
  fetchHotel() async {
    HotelListSink.add(HotelApiResponse.loading('Getting Hotel available'));
    try {
      List<Hotel> HotelList = await _HotelRepository.getHotel();
      HotelListSink.add(HotelApiResponse.completed(HotelList));
    } catch (e) {
      HotelListSink.add(HotelApiResponse.error('Error occurred'));
      print(e);
    }
  }
  dispose() {
    _controller?.close();
  }
}
