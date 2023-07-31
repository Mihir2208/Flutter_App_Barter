import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/authProvider.dart';
import 'dart:io';

import 'package:provider/provider.dart';


class ProductImage extends StatefulWidget {
  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  
  File _prodImage;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);



    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          authData.getImage().then((image) {
            setState(() {
              _prodImage = image;
            });
            if (image != null) {
              authData.isImgAvailable = true;
            }
          });
        },
        child: Container(
          height: 180,
          width: 180,
          child: Card(
              color: Colors.indigo[300],
              child: _prodImage == null
                  ? Center(
                      child: Icon(
                        CupertinoIcons.camera,
                        size: 50,
                        
                      ),
                    )
                  : Image.file(
                      _prodImage,
                      fit: BoxFit.fill,
                    )),
        ),
      ),
    );
  }
}