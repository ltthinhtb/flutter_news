import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/webview_page/webview_page.dart';

import 'package:flutter_news/service/database.dart';

import 'package:flutter_news/theme_bloc/chang_theme.dart';
import 'package:flutter_news/theme_bloc/change_theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils/apptheme.dart';

import 'page/main_page/main_page.dart';
import 'page/onboarding_page.dart';

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
                    id: msg['data']['id'],
                    photo: msg['data']['photo'],
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
                      ? AppTheme.darkTheme
                      : AppTheme.lightTheme),
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
    new Timer(new Duration(milliseconds: 1000), () {
      checkFirstSeen();
    });
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
