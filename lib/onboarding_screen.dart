import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static String id = 'onboarding_screen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

final _controller = PageController(initialPage: 0);
int _currentIndex = 0;

List<Widget> _pages = [
  Column(
    children: [
      Expanded(
        child: Image.asset('./assets/images/logo.png'),
      ),
      Text(
        'Select whatever you like...',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
      ),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('./assets/images/onboarding2.png')),
      Text(
        'Add your selected items in cart...',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
      ),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('./assets/images/onboarding3.png')),
      Text(
        'One click payment...',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
      ),
    ],
  ),
];

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          DotsIndicator(
            dotsCount: _pages.length,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              activeColor: Colors.indigoAccent,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      ),
    );
  }
}
