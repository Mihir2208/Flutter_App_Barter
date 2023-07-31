import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/authProvider.dart';
import 'package:provider/provider.dart';
import 'Animation/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _usernameTextController = TextEditingController();
  var _nameTextController = TextEditingController();
  var _emailTextController = TextEditingController();
  var _pwdTextController = TextEditingController();
  String email;
  String password;
  String username;

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);

    void handleSubmit() {
      if (_formKey.currentState.validate()) {
        _authData.userSignUp(email, password).then((credential) async {
          if (credential.user.uid != null) {
            await _authData.saveUserToDb(
                username: username, password: password);
            setState(() {
              _formKey.currentState.reset();
            });
            Navigator.of(context).popAndPushNamed(HomeScreen.id);
          } else {
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text(_authData.error)));
          }
        });
      } else {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Sign Up Failed...')));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 350.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30.0,
                    width: 80.0,
                    height: 200.0,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    left: 140.0,
                    width: 80.0,
                    height: 150.0,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    right: 40.0,
                    top: 40.0,
                    width: 80.0,
                    height: 150.0,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1.7,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10),
                              ),
                            ]),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _usernameTextController,
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter username...';
                                    }
                                    setState(() {
                                      username = value;
                                    });
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ('Username'),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _emailTextController,
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter email id...';
                                    }
                                    setState(() {
                                      email = value;
                                    });
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ('Email ID'),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _pwdTextController,
                                  style: TextStyle(color: Colors.black),
                                  obscureText: true,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a password...';
                                    }
                                    setState(() {
                                      password = value;
                                    });
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ('Password'),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  FadeAnimation(
                      1.7,
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ],
                          ),
                        ),
                        child: MaterialButton(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: handleSubmit,
                          minWidth: 400.0,
                          height: 42.0,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
