import 'dart:convert';
import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eats/DashBoard/Orders/OrderList.dart';
import 'package:flutter_eats/Db/Constants.dart';
import 'package:flutter_eats/Db/Model/OrderModal.dart';
import 'package:flutter_eats/Db/Networking/OrderNetworking/OrderResponse.dart';
import 'package:flutter_eats/Db/Services/OrderServices.dart';
import 'package:flutter_eats/Db/bloc/OrderBloc.dart';
import 'package:flutter_eats/LocalStorage/Cart.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  OrderBloc orderBloc;
  @override
  void initState() {
    super.initState();
    orderBloc = OrderBloc();
    orderBloc.fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Orders',style: TextStyle(color: kTextColor),),
        leading: BackButton(color: kTextColor,),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(onRefresh:()=>orderBloc.fetchOrder(),
        child: StreamBuilder(stream: orderBloc.orderListStream,builder: (context,snapshot){
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                print('loading');
                return Center(
                  child: new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
                break;
              case Status.COMPLETED:
                print('completed');
                return OrderList(orderList:snapshot.data.data);
                break;
              case Status.ERROR:
                print('error do');
                return new Container(
                  child: Center(
                      child: Text('No menu items found Add new Items...')),
                );
              // case Status.REFRESHING:
              //   return new Container(
              //     child: Center(
              //       child: Text("Reloading hotels..."),
              //     ),
              //   );
              //   break;
            }
          }
          return Container();
        }),
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        displacement: MediaQuery.of(context).size.height*.3,),
    );
  }
}


