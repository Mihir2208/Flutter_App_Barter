import 'package:flutter/material.dart';
import 'package:myapp/Home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Animation/FadeAnimation.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          child: Container(
            child: ListView(
              children: <Widget>[
                 Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill
                      )
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
                                  image: AssetImage('assets/images/light-1.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                          1.3,
                          Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                          1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/clock.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Log In", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[ FadeAnimation( 1.7,
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                style: TextStyle(color:  Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email Id",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                                onChanged: (value){
                                  email = value;
                                },
                              ),
                            )),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                style: TextStyle(color:  Colors.black),
                                obscureText: true,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                                onChanged: (value){
                                  password = value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      FadeAnimation(1.7,
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ]
                            )
                        ),
                        child: MaterialButton(
                          child: Text("Login",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async{
                            try {
                              final user = await _auth
                                  .signInWithEmailAndPassword(
                                  email: email, password: password);
                              if (user != null) {
                                Navigator.pushNamed(context, HomeScreen.id);
                              }
                            }
                            catch (e){
                              print(e);
                            }
                          },
                           minWidth: 400.0,
                           height: 42.0,
                        ),
                      )),
                      SizedBox(height: 70,),
                      Container(
                          child:Text("Forgot Password?",
                            style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

  