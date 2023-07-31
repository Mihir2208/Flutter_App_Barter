import 'package:flutter/material.dart';
import 'package:myapp/components/deal_products.dart';

class Deals extends StatefulWidget {
  Deals({
    transitionBetweenRoutes:false
  });
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo[300],
        title: Text('Deals'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
          ],
      ),
      body: new DealProducts(),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: new Text('Total:', style: TextStyle(color: Colors.black)),
              subtitle: new Text('\$20', style: TextStyle(color: Colors.black)),
            )),
            Expanded(child: new MaterialButton(onPressed: (){},
            child: new Text('Confirm Deal', style: TextStyle(color: Colors.black),),
            color: Colors.indigo[300],),
            )

        ],)
      ),
    );
  }
}