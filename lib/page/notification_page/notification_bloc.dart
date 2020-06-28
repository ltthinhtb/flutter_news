import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  BuildContext context;
  int isDark = 0;
  SharedPreferences prefs;
  AuthService authService = AuthService();
  List<DocumentSnapshot> listDoc;
  bool isLogin;

  @override
  // TODO: implement initialState
  NotificationState get initialState => InitNotificationState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadNotificationEvent) {
      yield event.isRefresh
          ? InitNotificationState()
          : NotificationLoadingState();
      isLogin = await authService.checkLogin();
      if (await getOption())
        isDark = 1;
      else
        isDark = 0;
      await getData();
      yield NotificationSuccessState(listDoc);
    }
  }

  Future<List<DocumentSnapshot>> getData() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('notification').getDocuments();
    listDoc = result.documents;
    return listDoc;
  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }
}
