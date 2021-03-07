import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eats/DashBoard/Hotel/Menu/Menucard.dart';
import 'package:flutter_eats/Db/Model/MenuModal.dart';

class MenuList extends StatefulWidget {
  List<Menu> menuData;

  MenuList({
    this.menuData,
  });

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    print(widget.menuData);
    return widget.menuData.length > 0
        ? Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.menuData.length,
                itemBuilder: (context, index) =>
                    MenuCard(menu: widget.menuData[index])),
          )
        : Center(
            child: Text(
            'No items found please add menu',
            style: TextStyle(fontSize: 18),
          ));
  }
}
