import 'package:flutter/material.dart';
import 'package:myapp/components/uiButton.dart';
import 'package:myapp/login_screen.dart';
import 'package:myapp/onboarding_screen.dart';
import 'package:myapp/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void handleRegistration() {
    Navigator.pushNamed(context, RegisterScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: OnBoardingScreen()),
            SizedBox(
              height: 15,
            ),
            uiButton(5, 50, 200, 'SIGN UP', 30, Colors.indigoAccent[100],
                handleRegistration),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                ),
                GestureDetector(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
