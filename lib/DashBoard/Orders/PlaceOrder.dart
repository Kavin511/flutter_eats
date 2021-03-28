import 'dart:convert';
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/DashBoard/Orders/Orders.dart';
import 'package:flutter_eats/DashBoard/Profile.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/AddressModal.dart';
import 'package:flutter_eats/Db/Model/CartArgument.dart';
import 'package:flutter_eats/Db/Model/CartModal.dart';
import 'package:flutter_eats/Db/Services/OrderServices.dart';
import 'package:flutter_eats/LocalStorage/AddressStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final AddressStorage addressStorage = new AddressStorage();
  CartArgument cartArgument = Get.arguments;
  bool emptyAddress = false;
  int selectedAddress = 0;
  TextEditingController address = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController state = TextEditingController();
  Size size;
  AddressModal addressModal;
  List addressList;
  final _formKey = GlobalKey<FormState>();
  final alertStyle = AlertStyle(
    animationType: AnimationType.fromBottom,
    isCloseButton: true,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: kPrimaryColor,
    ),
    alertAlignment: Alignment.center,
  );

  Widget addAddressButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: addressModal == null ? kPrimaryColor : kAccentColor,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              addressModal == null ? CupertinoIcons.add : CupertinoIcons.pencil,
              color: kMainColor,
            ),
            Text(
              addressModal == null
                  ? 'Add Location'.toUpperCase()
                  : 'change location'.toUpperCase(),
              style: TextStyle(
                  color: kMainColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Alert address_alert() {
    return Alert(
        context: context,
        title: "Address",
        style: alertStyle,
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Enter valid address';
                  }
                  return null;
                },
                controller: address,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
              ),
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Enter valid pin code';
                  }
                  return null;
                },
                controller: pinCode,
                decoration: InputDecoration(
                  labelText: 'Pin code',
                ),
              ),
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Enter valid district';
                  }
                  return null;
                },
                controller: district,
                decoration: InputDecoration(
                  labelText: 'District',
                ),
              ),
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Enter valid state';
                  }
                  return null;
                },
                controller: state,
                decoration: InputDecoration(
                  labelText: 'State',
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            color: kPrimaryColor,
            onPressed: () => {
              if (_formKey.currentState.validate())
                {
                  setState(() {
                    addressModal = new AddressModal(
                        address: address.text,
                        pinCode: pinCode.text,
                        district: district.text,
                        state: state.text);
                  }),
                  Navigator.pop(context)
                },
            },
            child: Text(
              "Add address",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]);
  }

  Widget addressView() {
    return Container(
      decoration: BoxDecoration(
          color: kMainColor, borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding / 4,
          bottom: kDefaultPadding / 4),
      child: ExpandablePanel(
        controller: ExpandableController(
          initialExpanded: false,
        ),
        theme: ExpandableThemeData(
          iconColor: kTextColor,
          tapBodyToExpand: true,
          inkWellBorderRadius: BorderRadius.circular(16),
          hasIcon: true,
          iconSize: 24,
        ),
        header: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  CupertinoIcons.location_solid,
                  color: kTextLightColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Deliver to ',
                  style: TextStyle(
                    fontSize: 16,
                    color: kTextLightColor,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  addressModal.address,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kTextLightColor,
                  ),
                ),
              )
            ],
          ),
        ),
        collapsed: null,
        expanded: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 2, vertical: kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                addressModal.address + ",",
                style: TextStyle(
                  fontSize: 16,
                  color: kTextLightColor,
                ),
              ),
              Text(addressModal.pinCode + ",",
                  style: TextStyle(
                    fontSize: 16,
                    color: kTextLightColor,
                  )),
              Text(addressModal.district + ",",
                  style: TextStyle(
                    fontSize: 16,
                    color: kTextLightColor,
                  )),
              Text(addressModal.state + ".",
                  style: TextStyle(
                    fontSize: 16,
                    color: kTextLightColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox cartSizedBox() {
    return SizedBox(
      height: cartArgument.cart.length * 120.0,
      child: ListView.builder(
          itemCount: cartArgument.cart.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundImage: AssetImage('images/food.jpg'),
                                radius: 25,
                              ),
                            ),
                            Text(
                              cartArgument.cart[index].menu.foodName,
                              style: TextStyle(
                                fontSize: 18,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            cartArgument.cart[index].count.toString(),
                            style:
                                TextStyle(fontSize: 18, color: kTextLightColor),
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '\$${cartArgument.cart[index].count * int.parse(cartArgument.cart[index].menu.price)}',
                          style:
                              TextStyle(fontSize: 18, color: kTextLightColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    addressList =
        addressStorage.getAddress() != null ? addressStorage.getAddress() : [];
    emptyAddress = addressList.length > 0 ? true : false;
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              cartSizedBox(),
              addressModal != null ? addressView() : Container(),
              Hero(
                tag: 'menuCard',
                child: SizedBox(
                  height: 75,
                  child: GestureDetector(
                    onTap: () => {address_alert().show()},
                    child: addAddressButton(),
                  ),
                ),
              ),
              addressModal != null ? placeOrderButton() : Container()
            ],
          ),
        ));
  }

  SizedBox placeOrderButton() {
    SharedPreferences prefs;
    Response response;
    return SizedBox(
      height: 55,
      child: GestureDetector(
        onTap: () async => {
          prefs = await SharedPreferences.getInstance(),
          print(prefs.getString('token')),
          OrderService().placeOrder(cartArgument).then((val) => {
                Get.off(Profile()),
              })
        },
        child: SizedBox(
          width: size.width,
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: kPrimaryColor,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    color: kMainColor,
                  ),
                  Text(
                    'Place order',
                    style: TextStyle(
                        color: kMainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackButton(
        color: kTextColor,
      ),
      title: Text(
        'Place Order',
        style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
// SizedBox checkAddress() {
//   return !emptyAddress
//       ? SizedBox(
//           height: 55,
//           child: GestureDetector(
//             onTap: () => {address_alert().show()},
//             child: addAddressButton(),
//           ),
//         )
//       : SizedBox(
//           height: addressList.length * 70.0,
//           child: addressListView(),
//         );
// }

// ListView addressListView() {
//   return ListView.builder(
//     itemCount: addressList.length,
//     itemBuilder: (context, index) {
//       Map<String, dynamic> addressMap = json.decode(addressList[index]);
//       return Dismissible(
//         key: UniqueKey(),
//         onDismissed: (direction) async {
//           deleteAddressFromList(addressList[index]);
//         },
//         child: RadioListTile(
//           value: index,
//           title: Text(addressMap['address']),
//           groupValue: 1,
//           onChanged: (value) {
//             setState(() {});
//           },
//         ),
//         background: Container(
//           color: Colors.red,
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           alignment: AlignmentDirectional.centerStart,
//           child: Icon(
//             Icons.delete,
//             color: Colors.white,
//           ),
//         ),
//         secondaryBackground: Container(
//           color: Colors.red,
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           alignment: AlignmentDirectional.centerEnd,
//           child: Icon(
//             Icons.delete,
//             color: Colors.white,
//           ),
//         ),
//       );
//     },
//   );
// }

// deleteAddressFromList(addressEntry) {
//   List addressList =
//       addressStorage.getAddress() != null ? addressStorage.getAddress() : [];
//   List finalList = [];
//   for (int i = 0; i < addressList.length; i++) {
//     if (addressEntry != addressList[i]) finalList.add(addressList[i]);
//   }
//   if (finalList.length == 0) {
//     setState(() {
//       emptyAddress = true;
//     });
//   }
//   addressStorage.addAddress(finalList);
// }
