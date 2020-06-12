import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/web_page/webview_page.dart';
import 'package:flutter_news/service/database.dart';

import 'package:flutter_news/theme_bloc/chang_theme.dart';
import 'package:flutter_news/theme_bloc/change_theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils/apptheme.dart';
import 'page/main_page/main_page.dart';
import 'page/onboarding_page.dart';
import 'page/web_page/webview_page.dart';

import 'theme_bloc/change_theme_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  // ignore: close_sinks
  ChangeThemeBloc _bloc;

  @override
  void initState() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> msg) async {
        await DataBase(uid: msg['data']['id']).userNotification(
            msg['data']['title'],
            msg['data']['photo'],
            msg['data']['url'],
            msg['data']['id']);
        print("onMessage: $msg");
      },
      onLaunch: (Map<String, dynamic> msg) async {
        await DataBase(uid: msg['data']['id']).userNotification(
            msg['data']['title'],
            msg['data']['photo'],
            msg['data']['url'],
            msg['data']['id']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewPage(
//                    id: msg['data']['id'],
//                    photo: msg['data']['photo'],
                    url: msg['data']['url'],
                    title: msg['data']['title'])));
        print("onLaunch: $msg");
      },
      onResume: (Map<String, dynamic> msg) async {
        await DataBase(uid: msg['data']['id']).userNotification(
            msg['data']['title'],
            msg['data']['photo'],
            msg['data']['url'],
            msg['data']['id']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewPage(
                    id: msg['data']['id'],
                    photo: msg['data']['photo'],
                    url: msg['data']['url'],
                    title: msg['data']['title'])));
        print("onResume: $msg");
      },
    );
    _fcm.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _bloc = ChangeThemeBloc();
    _bloc.add(LoadThemeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
        builder: (context, state) {
          return MaterialApp(
              title: "Báo Lá Cải",
              debugShowCheckedModeBanner: false,
              theme: _bloc.optionValue == null
                  ? ThemeData.light()
                  : (_bloc.optionValue
                      ? ThemeData.dark()
                      : ThemeData(
                          brightness: Brightness.light,
                          appBarTheme: AppBarTheme(
                            color: AppTheme.dark_grey,
                          ))),
              home: SplashScreen());
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => OnBoardingPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 3000), () {
      checkFirstSeen();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromRGBO(0, 0, 0, 0.3),
                Color.fromRGBO(0, 0, 0, 0.4)
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    Hero(
                      tag: "BaoLaCai",
                      child: Text(
                        "Giao Hàng Tiết Kiệm",
                        style: TextStyle(
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w900,
                          fontSize: 35.0,
                          letterSpacing: 0.4,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
