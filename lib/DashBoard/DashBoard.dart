import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/DashBoard/Hotel/Hotel/Home.dart';
import 'file:///D:/C%20files/AndroidStudioProjects/flutter_eats/lib/DashBoard/Orders/Orders.dart';
import 'package:flutter_eats/DashBoard/Profile.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Services/ProfileServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      return new Text(
        text,
        style: TextStyle(color: kTextColor),
      );
    }
    return Scaffold(
      appBar: buildAppBar(actionBarText),
      extendBodyBehindAppBar: true,
      extendBody: true,
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 100,
      //   backgroundColor: Colors.redAccent.withOpacity(.1),
      //   onTap: (index) => {
      //     this._pageController.animateToPage(index,
      //         duration: const Duration(milliseconds: 100),
      //         curve: Curves.easeInToLinear),
      //   },
      //   currentIndex: _pageIndex,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.restaurant), label: 'Restaurants'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart), label:'Cart'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label:'Profile')
      //   ],
      // ),
      // body: PageView(
      //   children: tabList,
      //   controller: _pageController,
      //   onPageChanged: onPageChange,
      // )
      body: Home(),
    );
  }
  AppBar buildAppBar(Widget actionBarText()) {
    SharedPreferences prefs;
    return AppBar(
      title: actionBarText(),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      backwardsCompatibility: true,
      leading: IconButton(
          icon: Icon(
            CupertinoIcons.person_crop_circle,
            size: 30,
            color: kTextColor,
          ),
        // icon: FlutterLogo(
        //   size: 30,
        //   duration: Duration(seconds: 1000),
        // ),
          onPressed: ()  {

            ProfileSerivces().userData().then((v)=>{
            Get.toNamed('/profile',arguments: v),
            });

              }),
      actions: [
        IconButton(
            icon: Image.asset('images/bag.png',color: kTextColor,width: 30,height: 30,),
            onPressed: () => {Get.toNamed('/orders')}),
        SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }

  onTabChanged(int index) {}

  void onPageChange(int value) {
    setState(() {
      this._pageIndex = value;
      this.text = value == 0 ? "Restaurant" : (value == 1 ? "Cart" : "Profile");
    });
  }
}
