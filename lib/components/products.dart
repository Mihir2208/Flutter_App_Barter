import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  void getProduct() async {
    QuerySnapshot users =
        await FirebaseFirestore.instance.collection('users').get();
    print('hi user');
    print(users.docs.length);
    users.docs.forEach((doc) async {
      print(doc.data()['uid']);
      QuerySnapshot product = await FirebaseFirestore.instance
          .collection('users')
          .doc(doc.data()['uid'])
          .collection('products')
          .get();
      print('hi product');
      print(product.docs.length);

      product.docs.forEach((prod) {
        print(prod.id);
        Map data = prod.data();
        print(data);
        Map pushingData = {
          "name": data['name'],
          "picture": data['url'],
          "old_price": 100,
          "price": data['price'],
          "detail": data['details'],
          "seller": data['seller'],
          "condition": data['condition'],
          "category": data['category'],
          "brand": data['brand']
        };
        setState(() {
          product_list.add(pushingData);
        });
      });
    });
  }

  // ignore: non_constant_identifier_names
  var product_list = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: product_list.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Single_prod(
                product_name: product_list[index]['name'],
                product_picture: product_list[index]['picture'],
                product_old_price: product_list[index]['old_price'],
                prod_price: product_list[index]['price'],
                product_detail: product_list[index]['detail'],
                seller_name: product_list[index]['seller'],
                prod_condition: product_list[index]['condition'],
                prod_category: product_list[index]['category'],
                prod_brand: product_list[index]['brand'],);
          }),
    );
  }
}

// ignore: camel_case_types
class Single_prod extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final product_name;
  // ignore: non_constant_identifier_names
  final product_picture;
  // ignore: non_constant_identifier_names
  final product_old_price;
  // ignore: non_constant_identifier_names
  final prod_price;
  final product_detail;
  final seller_name;
  final prod_condition;
  final prod_category;
  final prod_brand;

  Single_prod(
      // ignore: non_constant_identifier_names
      {this.prod_price,
      // ignore: non_constant_identifier_names
      this.product_name,
      // ignore: non_constant_identifier_names
      this.product_old_price,
      // ignore: non_constant_identifier_names
      this.product_picture,
      this.product_detail,this.seller_name,this.prod_condition,this.prod_category,this.prod_brand});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new ProductDetails(
                      product_detail_name: product_name,
                      product_detail_new_price: prod_price,
                      product_detail: product_detail,
                      product_detail_brand: prod_brand,
                      product_detail_category: prod_category,
                      product_detail_picture: product_picture,
                      product_detail_condition: prod_condition,
                    ))),
          child: Container(
        height: 180,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.indigo[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.network(product_picture),
            ),
            Container(
              width: 10,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product_name,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  Text(' Sold by: ${seller_name}',style: TextStyle(color: Colors.black54,fontStyle: FontStyle.italic)),
                  SizedBox(height: 10),
                  Row(children: [
                    Text(' ${prod_price} \$',style: TextStyle(color: Colors.red,fontSize:16,fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(

          decoration: BoxDecoration(
            color: prod_condition=='New' ? Colors.indigoAccent : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
          ),
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(3),
          child: new Text('New')),
          Container(
          decoration: BoxDecoration(
            color: prod_condition=='Refurbished' ? Colors.indigoAccent : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
          ),
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(3),
          child: new Text('Refurbished',style: TextStyle(color: prod_condition!='Refurbished' ? Colors.black : Colors.white))),
          Container(
          decoration: BoxDecoration(
            color: prod_condition=='Old' ? Colors.indigoAccent : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
          ),
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(3),
          child: new Text('Old',style: TextStyle(color: prod_condition!='Old' ? Colors.black : Colors.white),)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Category: ${prod_category}',style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                  Text('Brand: $prod_brand',style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
