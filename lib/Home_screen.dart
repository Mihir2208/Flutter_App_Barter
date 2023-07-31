import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/screens/addProduct.dart';
import 'package:myapp/welcome_screen.dart';
import 'components/Horizontal_Listview.dart';
import 'components/products.dart';
import 'pages/deals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'homepage';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  User loggedInUser;
  bool isLoggedIn = false;
  String userName;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    setState(() {
      loggedInUser = _auth.currentUser;
    });
    if (loggedInUser != null) {
      fetchUser(loggedInUser.uid);

      setState(() {
        isLoggedIn = true;
      });
    }
  }

  void fetchUser(String id) {
    _firestore.collection('users').doc(id).get().then((doc) {
      if (doc.data() == null) {
        return null;
      } else {
        setState(() {
          userName = doc.data()['username'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 200,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/hello.jpg'),
          AssetImage('assets/images/hello1.jpg'),
          AssetImage('assets/images/hello2.jpg'),
          AssetImage('assets/images/hello3.jpg'),
          AssetImage('assets/images/hello4.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4,
        indicatorBgPadding: 8,
      ),
    );
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Deals()));
              })
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
//              header
            new UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: Text(loggedInUser.email),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.indigo[300],
              ),
            ),
//            body
            InkWell(
              onTap: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.arrow_back_ios),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Deals()));
              },
              child: ListTile(
                title: Text('Deals'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('WishList'),
                leading: Icon(Icons.favorite),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          //caraousel begining
          imageCarousel,
          //widget padding
          new Padding(
            padding: const EdgeInsets.all(8),
            child: new Text('  Categories',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          //horizontal listview of categories begining
          HorizontalList(),

          new Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Text('Recent products'),
          ),
          Container(
            height: 320,
            child: Products(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.indigoAccent,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProduct(
                        id: loggedInUser.uid,
                        sellerName: userName,
                        sellerEmail: loggedInUser.email)));
          }),
    );
  }
}
