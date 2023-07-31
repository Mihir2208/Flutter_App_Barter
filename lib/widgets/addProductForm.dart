import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/Home_screen.dart';
import 'package:myapp/components/uiButton.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../widgets/inputBox.dart';
import 'package:myapp/providers/authProvider.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  String uid;
  String seller;
  String email;
  AddProductForm({this.uid, this.seller, this.email});

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  var _sellerNameController = TextEditingController();
  var _sellerEmailController = TextEditingController();
  var _productNameController = TextEditingController();
  var _productDetailsController = TextEditingController();
  var _productBrandController = TextEditingController();
  var _prodConditionController = TextEditingController();
  var _prodPriceController = TextEditingController();
  var _prodCategoryController = TextEditingController();

  String _prodName;
  String _sellerName;
  String _sellerEmail;
  String _prodDetails;
  String _prodBrand;
  String _prodCondition;
  String _prodPrice;
  String _prodCategory;
  String dropdownValue = 'New';
  bool _isLoading = false;

  Future<String> uploadFile(String filePath) async {
    File file = File(filePath);
    FirebaseStorage firebase_storage = FirebaseStorage.instance;
    final storageRef =
        firebase_storage.ref('uploads/${_sellerNameController.text}/');
    String downloadURL;
    try {
      UploadTask uploadTask = storageRef.child(Uuid().v4()).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      downloadURL = await snapshot.ref.getDownloadURL();
      // await firebase_storage
      //     .ref('uploads/${_sellerNameController.text}/${Uuid().v4()}/')
      //     .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
    // String downloadURL = await firebase_storage
    //     .ref('uploads/${_sellerNameController.text}/${Uuid().v4()}/')
    //     .getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);

    void handleUpload() {
      if (authData.isImgAvailable == true) {
        setState(() {
          _isLoading = true;
        });
        if (_formKey.currentState.validate()) {
          if (widget.uid != null) {
            uploadFile(authData.prodImage.path).then((url) {
              if (url != null) {
                authData.updateUser({
                  'id': widget.uid,
                  'seller': _sellerName,
                  'name': _prodName,
                  'details': _prodDetails,
                  'brand': _prodBrand,
                  'price': _prodPrice,
                  'condition': dropdownValue,
                  'category': _prodCategory,
                  'url': url,
                }).then((value) {
                  setState(() {
                    _formKey.currentState.reset();
                    _isLoading = false;
                  });
                });
                Navigator.pushNamed(context, HomeScreen.id);
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Something went wrong!'),
                ));
              }
            });
          }
        }
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please add product image'),
        ));
      }
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: _isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.indigo[300]))
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    initialValue: widget.seller,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter seller name';
                      }
                      setState(() {
                        _sellerNameController.text = val;
                        _sellerName = val;
                      });
                      return null;
                    },
                    decoration:
                        textFieldInputDecoration('Seller Name', 'Seller', null),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    initialValue: widget.email,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter seller email';
                      }
                      setState(() {
                        _sellerEmailController.text = val;
                        _sellerEmail = val;
                      });
                      return null;
                    },
                    decoration: textFieldInputDecoration(
                        'Seller Email', 'Seller Email Id', null),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter product name';
                      }
                      setState(() {
                        _productNameController.text = val;
                        _prodName = val;
                      });
                      return null;
                    },
                    decoration: textFieldInputDecoration(
                        'Enter product name', 'Product Name', null),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    maxLines: 5,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter product details';
                      }
                      setState(() {
                        _productDetailsController.text = val;
                        _prodDetails = val;
                      });
                      return null;
                    },
                    decoration: textFieldInputDecoration(
                        'Enter product details', 'Product Details', null),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Enter product brand';
                            }
                            setState(() {
                              _productBrandController.text = val;
                              _prodBrand = val;
                            });
                            return null;
                          },
                          decoration: textFieldInputDecoration(
                              'Enter product brand name',
                              'Product Brand',
                              null),
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(
                          CupertinoIcons.arrow_down,
                          color: Colors.indigo,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline:
                            Container(height: 2, color: Colors.indigoAccent),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['New', 'Old', 'Refurbished']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter product price';
                      }
                      setState(() {
                        _prodPriceController.text = val;
                        _prodPrice = val;
                      });
                      return null;
                    },
                    decoration: textFieldInputDecoration(
                        'Enter product price', 'Product Price', null),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter product category';
                      }
                      setState(() {
                        _prodCategoryController.text = val;
                        _prodCategory = val;
                      });
                      return null;
                    },
                    decoration: textFieldInputDecoration(
                        'Enter product Category', 'Product Category', null),
                  ),
                  SizedBox(height: 15),
                  uiButton(5, 50, 200, 'ADD PRODUCT', 30, Colors.indigoAccent,
                      handleUpload),
                ],
              ),
            ),
    );
  }
}
