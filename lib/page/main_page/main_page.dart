import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/Utils/apptheme.dart';
import 'package:flutter_news/page/covid_page/covid.dart';
import 'package:flutter_news/page/home_page/home_page.dart';
import 'package:flutter_news/page/profile_page/profile_page.dart';
import 'package:flutter_news/page/notification_page/notification_page.dart';

class MyHomePage extends StatefulWidget {
  final int currentPage;

  const MyHomePage({Key key, this.currentPage}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomePage(),
            CovidPage(),
            NotificationPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: AppTheme.deactivatedText,
              title: Text('Trang chủ'),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: AppTheme.deactivatedText,
              title: Text('Danh mục'),
              icon: Icon(Icons.apps)),
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: AppTheme.deactivatedText,
              title: Text('Thông báo'),
              icon: Icon(Icons.notifications)),
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: AppTheme.deactivatedText,
              title: Text('Cá nhân'),
              icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
