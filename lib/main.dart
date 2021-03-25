import 'package:flutter/material.dart';
import 'package:flutter_eats/Authentication/Login.dart';
import 'package:flutter_eats/Authentication/SignUp.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'file:///D:/C%20files/AndroidStudioProjects/flutter_eats/lib/DashBoard/Hotel/Hotel/HotelDetails.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashBoard/DashBoard.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(token);
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  static var route = [
    GetPage(name: '/', page: () => LoginPage()),
    GetPage(name: '/signUp', page: () => SignUp()),
    GetPage(name: '/dashboard', page: () => Dashboard()),
    GetPage(name: '/hotelDetails', page: () => HotelDetails()),
  ];
  final token;
  MyApp({this.token});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColorBrightness: Brightness.light,
          primarySwatch: Colors.red,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor)),
      home: token == null ? LoginPage() : Dashboard(),
      debugShowCheckedModeBanner: false,
      getPages: route,
      initialRoute: token == null ? '/' : "/dashboard",
    );
  }
}



