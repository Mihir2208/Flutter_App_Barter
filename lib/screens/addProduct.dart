import 'package:flutter/material.dart';
import 'package:myapp/widgets/addProductForm.dart';
import 'package:myapp/widgets/productImage.dart';

class AddProduct extends StatefulWidget {
  String id;
  String sellerName;
  String sellerEmail;
  AddProduct({this.id, this.sellerName,this.sellerEmail});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
                  child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Product',
                      style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              ProductImage(),
              AddProductForm(uid: widget.id,seller: widget.sellerName,email: widget.sellerEmail),
            ],
          ),
        ),
      ),
    );
  }
}
