
import 'package:flutter/material.dart';
import 'package:flutter_news/page/covid_page/covid.dart';
import 'package:flutter_news/page/home_page/home_page.dart';
import 'package:flutter_news/page/profile_page/profile_page.dart';
import 'package:flutter_news/page/notification_page/notification_page.dart';
import 'package:flutter_news/Icon/icon_tab_icons.dart';

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
    widget.currentPage != null
        ? _currentIndex = widget.currentPage
        : _currentIndex = 0;
    _pageController =
        PageController(initialPage: widget.currentPage ?? _currentIndex);
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.grey[500]),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide( color: Colors.black12, width: 1.2)
            )
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            //selectedIndex: _currentIndex,
  //        onItemSelected: (index) {
  //          setState(() => _currentIndex = index);
  //          _pageController.jumpToPage(index);
  //        },
            onTap: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconTab.newspaper),
                title: Container(child: Text('Tin tức', style: ts,),),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconTab.heart),
                title: Container(child: Text('Covid 19', style: ts,),),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconTab.bell),
                title: Container(child: Text('Thông báo', style: ts,),),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconTab.user),
                title: Container(child: Text('Cá nhân', style: ts,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  TextStyle ts = TextStyle(
    fontWeight: FontWeight.w500,
  );
}
