import 'package:flutter/material.dart';
import 'package:myapp/screens/chatRoom.dart';

class ProductDetails extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final product_detail_name;
  // ignore: non_constant_identifier_names
  final product_detail_new_price;
  // ignore: non_constant_identifier_names
  final product_detail_brand;
  // ignore: non_constant_identifier_names
  final product_detail_category;
  final product_detail_picture;
  final product_detail;
final  product_detail_condition;

  ProductDetails(
      {
      // ignore: non_constant_identifier_names
      this.product_detail_name,
      // ignore: non_constant_identifier_names
      this.product_detail_new_price,
      // ignore: non_constant_identifier_names
      this.product_detail_picture,
      // ignore: non_constant_identifier_names
      this.product_detail_brand,
      this.product_detail_category,
      this.product_detail,
      this.product_detail_condition
      });
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo[300],
        title: Text('barterApp'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {})
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.product_detail_picture),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    widget.product_detail_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Expanded(
                      //   child: new Text(
                      //     "\$${widget.product_detail_old_price}",
                      //     style: TextStyle(
                      //         color: Colors.grey,
                      //         decoration: TextDecoration.lineThrough),
                      //   ),
                      // ),
                      Expanded(
                        child: new Text(
                          "\$${widget.product_detail_new_price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Size"),
                            content: new Text("Choose the size",
                                style: TextStyle(color: Colors.black)),
                            actions: <Widget>[
                              new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text(
                                    'close',
                                  )),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Size"),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Size"),
                            content: new Text("Choose the color",
                                style: TextStyle(color: Colors.black)),
                            actions: <Widget>[
                              new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text(
                                    'close',
                                  )),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Color"),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Quantity"),
                            content: new Text("Choose the quantity",
                                style: TextStyle(color: Colors.black)),
                            actions: <Widget>[
                              new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text(
                                    'close',
                                  )),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Qty"),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    color: Colors.indigo[300],
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Buy Now")),
              ),
              new IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.indigo[300],
                  ),
                  onPressed: () {}),
              new IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.indigo[300],
                  ),
                  onPressed: () {}),
                  IconButton(icon: Icon(Icons.comment,color: Colors.indigo[300]),onPressed: (){Navigator.pushNamed(context, ChatRoom.id);})
            ],
          ),
          Divider(),
          new ListTile(
            title: new Text('Product Details',
                style: TextStyle(color: Colors.indigoAccent,fontWeight: FontWeight.bold,fontSize: 18)),
            subtitle: new Text(widget.product_detail,
                style: TextStyle(color: Colors.black)),
          ),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_name,
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child:
                    new Text(widget.product_detail_brand, style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product condition",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_condition, style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
