import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'main_page/main_page.dart';




class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Popins",
    fontSize: 21.0,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
    letterSpacing: 1.5
);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Sans",
    fontSize: 20.0,
    color: Colors.black,
    fontWeight: FontWeight.w400
);


final pages = [
  new PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Tikin Shop',style: _fontHeaderStyle,
      ),
      body: Text(
          'Bấm là có',textAlign: TextAlign.center,
          style: _fontDescriptionStyle
      ),
      mainImage: Image.asset(
        'assets/images/IlustrasiOnBoarding1.jpg',
        fit: BoxFit.cover,
        alignment: Alignment.center,
      )),

  new PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'RICARDO Shop',style: _fontHeaderStyle,
      ),
      body: Text(
          'Mọi thứ đều có',textAlign: TextAlign.center,
          style: _fontDescriptionStyle
      ),
      mainImage: Image.asset(
        'assets/images/IlustrasiOnBoarding2.jpg',
        fit: BoxFit.cover,
        alignment: Alignment.center,
      )),

  new PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Tikin Shop',style: _fontHeaderStyle,
      ),
      body: Text(
          'Mọi lúc mọi nơi',textAlign: TextAlign.center,
          style: _fontDescriptionStyle
      ),
      mainImage: Image.asset(
        'assets/images/IlustrasiOnBoarding3.jpg',
        fit: BoxFit.cover,
        alignment: Alignment.center,
      )),

];

class _OnBoardingPageState extends State<OnBoardingPage> {


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () {
          Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder:(_,__,___,)=> MyHomePage() ));
        },
        pageButtonTextStyles: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ), //IntroViewsFlutter
    ); //Builder
  }
}
