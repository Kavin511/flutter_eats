import 'dart:async';

import 'package:flutter_eats/Db/Model/MenuModal.dart';
import 'package:flutter_eats/Db/Networking/MenuNetworking/MenuResponse.dart';
import 'package:flutter_eats/Db/Repository/MenuRepository.dart';
import 'package:flutter_eats/jwtDecoder/jwtDecoder.dart';

class MenuBloc {
  MenuRepository _menuRepository;
  StreamController _controller;

  StreamSink<MenuApiResponse<List<Menu>>> get menuListSink => _controller.sink;

  Stream<MenuApiResponse<List<Menu>>> get menuListStream => _controller.stream;

  MenuBloc() {
    _controller = StreamController<MenuApiResponse<List<Menu>>>();
    _menuRepository = MenuRepository();
    fetchMenu("");
  }

  fetchMenu(String mobileNumber) async {
    menuListSink.add(MenuApiResponse.loading('Getting menu available'));
    try {
      List<Menu> menuList = await _menuRepository.getMenu(mobileNumber);
      menuListSink.add(MenuApiResponse.completed(menuList));
    } catch (e) {
      menuListSink.add(MenuApiResponse.error('Error occurred'));
      print(e);
    }
  }
  dispose() {
    _controller?.close();
  }
}
