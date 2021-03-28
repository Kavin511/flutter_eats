import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Services/ProfileServices.dart';
import 'package:get/route_manager.dart';

// import 'package:get/get_core/get_core.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var token = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> profile = JwtDecoder.decode(token);
    print(profile);
    SharedPreferences prefs;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: kTextColor,
        ),
        title: Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(kDefaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Kavin',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(color: kTextLightColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              profile['mobileNumber'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: kTextLightColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              profile['email'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: kTextLightColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(kDefaultPadding / 2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.fastfood_outlined,
                            color: kTextColor,
                          ),
                          backgroundColor: kMainColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(.5),
              thickness: 1,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.fastfood_outlined),
                            onPressed: () => {}),
                        Text(
                          'Food Orders',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: kTextColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'View orders',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: kTextColor),
                          ),
                          IconButton(
                            icon: Image.asset('images/bag.png',height: 24,width: 24,color: kTextColor,),
                            onPressed: (){
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(.5),
              thickness: 1,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              CupertinoIcons.settings,
                              size: 24,
                              color: kTextColor,
                            ),
                            onPressed: () => {}),
                        Text(
                          'Settings',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: kTextColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Change Theme',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: kTextColor),
                              ),
                              IconButton(
                                  icon: Get.isDarkMode
                                      ? Icon(CupertinoIcons.sun_max)
                                      : Icon(CupertinoIcons.moon),
                                  onPressed: () => {
                                        Get.changeTheme(Get.isDarkMode
                                            ? ThemeData.light()
                                            : ThemeData.dark()),
                                      })
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Log out',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: kTextColor),
                              ),
                              IconButton(
                                  icon: Icon(CupertinoIcons.square_arrow_right),
                                  onPressed: () async => {
                                        prefs =
                                            await SharedPreferences.getInstance(),
                                        prefs.remove('token'),
                                        Get.toNamed('/')
                                      })
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(.5),
              thickness: 1,
            ),

          ],
        ),
      ),
    );
  }
}
