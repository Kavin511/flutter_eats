import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/DashBoard/Hotel/Hotel/Home.dart';
import 'package:flutter_eats/DashBoard/Orders.dart';
import 'package:flutter_eats/DashBoard/Profile.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _pageIndex = 0;
  String text = "Restaurants";
  List<Widget> tabList = [Home(), Order(), Profile()];
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  void onTabTapped(int index) {}

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget actionBarText() {
      return new Text(text);
    }

    setState(() {});
    return Scaffold(
        appBar: AppBar(
          title: actionBarText(),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 100,
          backgroundColor: Colors.redAccent.withOpacity(.1),
          onTap: (index) => {
            this._pageController.animateToPage(index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInToLinear),
          },
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant), label: 'Restaurants'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label:'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label:'Profile')
          ],
        ),
        body: PageView(
          children: tabList,
          controller: _pageController,
          onPageChanged: onPageChange,
        ));
  }

  onTabChanged(int index) {}

  void onPageChange(int value) {
    setState(() {
      this._pageIndex = value;
      this.text =
          value == 0 ? "Restaurant" : (value == 1 ? "Cart" : "Profile");
    });
  }
}
