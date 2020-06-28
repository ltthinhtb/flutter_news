import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Utils/validator.dart';
import 'package:flutter_news/models/response/user.dart';

import 'package:flutter_news/service/auth_service.dart';
import 'package:flutter_news/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'webview.dart';

class WebViewPageBloc extends Bloc<WebViewPageEvent, WebViewPageState>
    with Validators {
  SharedPreferences prefs;
  AuthService authService = AuthService();
  String errorEmail;
  User user;
  BuildContext context;
  DocumentSnapshot doc;
  int count;

  @override
  // TODO: implement initialState
  WebViewPageState get initialState => InitWebViewPageState();

  @override
  Stream<WebViewPageState> mapEventToState(WebViewPageEvent event) async* {
    if (event is LoadWebViewEvent) {
      yield event.isRefresh ? InitWebViewPageState() : WebViewPageLoading();
      user = await getUser();
      await getData(id: event.id);
      yield WebViewPageSuccess(user: user);
    }
  }

  Future<User> getUser() async {
    prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('userId') ?? null;
    user = await DataBase(uid: userId).dataUser();
    return user;
  }

  Future<DocumentSnapshot> getData({String id}) async {
    prefs = await SharedPreferences.getInstance();
    final databaseReference = Firestore.instance;
    var usersRef = databaseReference.collection("post");
    doc = await usersRef.document(id).get();
    if (doc.data == null)
      count = 0;
    else
      count = doc.data["comment"].length;
    return doc;
  }
}
