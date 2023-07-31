import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imageLocation: 'assets/images/tshirt.png',
            imageCaption: 'T-Shirt',
          ),
          Category(
            imageLocation: 'assets/images/accessories.png',
            imageCaption: 'Accessories',
          ),
          Category(
            imageLocation: 'assets/images/dress.png',
            imageCaption: 'Dress',
          ),
          Category(
            imageLocation: 'assets/images/formal.png',
            imageCaption: 'Formals',
          ),
          Category(
            imageLocation: 'assets/images/informal.png',
            imageCaption: 'Informals',
          ),
          Category(
            imageLocation: 'assets/images/jeans.png',
            imageCaption: 'Jeans',
          ),
          Category(
            imageLocation: 'assets/images/shoe.png',
            imageCaption: 'Shoe',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({this.imageLocation, this.imageCaption});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
          onTap: () {},
          child: Container(
            width: 120,
            child: ListTile(
              title: Image.asset(
                imageLocation,
                width: 100,
                height: 80,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  imageCaption,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          )),
    );
  }
}
