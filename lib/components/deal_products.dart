import 'package:flutter/material.dart';

class DealProducts extends StatefulWidget {
  @override
  _DealProductsState createState() => _DealProductsState();
}

class _DealProductsState extends State<DealProducts> {
  var productsDealed = [
  
    {
      "name": "Skirt",
      "picture": "assets/images/skt1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
     {
      "name": "Blazer",
      "picture": "assets/images/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1,
    },
 
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: productsDealed.length,
      itemBuilder: (context, int index){
        return SingleProudctDeal(
          deal_product_name: productsDealed[index]["name"],
          deal_product_color: productsDealed[index]["color"],
          deal_product_quantity: productsDealed[index]["quantity"],
          deal_product_size: productsDealed[index]["size"],
          deal_product_picture: productsDealed[index]["picture"],
          deal_product_price: productsDealed[index]["price"],
        ) ;
      }
    );
  }
}
class SingleProudctDeal extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final deal_product_name;
  // ignore: non_constant_identifier_names
  final deal_product_picture;
  // ignore: non_constant_identifier_names
  final deal_product_price;
  // ignore: non_constant_identifier_names
  final deal_product_size;
  // ignore: non_constant_identifier_names
  final deal_product_color;
  // ignore: non_constant_identifier_names
  final deal_product_quantity;

  SingleProudctDeal({
    // ignore: non_constant_identifier_names
    this.deal_product_name,
    // ignore: non_constant_identifier_names
    this.deal_product_picture,
    // ignore: non_constant_identifier_names
    this.deal_product_price,
    // ignore: non_constant_identifier_names
    this.deal_product_size,
    // ignore: non_constant_identifier_names
    this.deal_product_color,
    // ignore: non_constant_identifier_names
    this.deal_product_quantity
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: ListTile(
        leading: new Image.asset(deal_product_picture, width:80.0, height: 80.0), //image of product 
        title: new Text(deal_product_name, style: TextStyle(color: Colors.black)), //title of product 
        subtitle: new Column(
          children: <Widget>[
            new Row(children: <Widget>[
              //size of products
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: new Text("Size:", style: TextStyle(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Text(deal_product_size, style: TextStyle(color: Colors.black),),
              ),

              //color of product
             Padding(padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
             child: new Text("Color:", style: TextStyle(color: Colors.black)),),
             Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Text(deal_product_color, style: TextStyle(color: Colors.black),),
              ),
              
            ],
            ),
            //price of product 
            new Container(
              alignment: Alignment.topLeft,
              child: new Text("\$$deal_product_price",
               style: TextStyle(
                 fontSize: 16.0,
                 fontWeight: FontWeight.bold,
                 color: Colors.black,
                 ),
                 ),

            )

          ],
        ),
        // trailing: new SingleChildScrollView(
        //   child: Column(
        //   children: <Widget>[
            
        //     new IconButton( icon: Icon(Icons.arrow_drop_up), onPressed: () {},),
        //     new Text("$deal_product_quantity"),
        //     new IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: () {}, )
            

        //   ],
        // ),
        // ),
      ),
      
    );
  }
  
  
}
