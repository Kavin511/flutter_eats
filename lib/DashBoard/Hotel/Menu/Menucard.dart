import 'package:flutter/material.dart';
import 'package:flutter_eats/Db/Model/MenuModal.dart';

class MenuCard extends StatefulWidget {
  
  Menu menu;
  MenuCard({
    this.menu
});
  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  var _n=0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('images/food.jpg'),
            radius: 50,
          ),
          Column(
            children: [
              RichText(text: TextSpan(
                style: TextStyle(
                  color: Colors.black
                ),
                text: widget.menu.foodName,
                children: [
                  WidgetSpan(child: Icon(Icons.restaurant))
                ]
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new FloatingActionButton(
                onPressed: ()=>{
                },
                child: new Icon(Icons.add, color: Colors.black,),
                backgroundColor: Colors.white,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text('$_n',
                    style: new TextStyle(fontSize: 15.0)),
              ),

              new FloatingActionButton(
                onPressed: ()=>{
                },
                child:  Icon(Icons.remove, color: Colors.black,),
                backgroundColor: Colors.white,),
            ],
          ),
        ],
      ),
    );
  }
}
