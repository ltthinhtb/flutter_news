import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/models/response/user.dart';
import 'package:flutter_news/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  BuildContext context;
  int isDark = 0;
  SharedPreferences prefs;
  DocumentSnapshot doc;
  User user;
  String userId;
  String commentId;

  @override
  // TODO: implement initialState
  CommentState get initialState => InitCommentState();

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is LoadCommentEvent) {
      yield event.isRefresh ? InitCommentState() : CommentLoadingState();
      user = await getUser();
      if (await getOption())
        isDark = 1;
      else
        isDark = 0;
      await getData(id: event.id);
      yield CommentSuccessState(listDoc: doc);
    }
    if (event is SaveCommentEvent) {
      yield InitCommentState();
      DataBase().saveComment(id: event.id,
          url: user.photoUrl,
          comment: event.comment,
          timestamp: Timestamp.now(),
          userId: userId,
          userName: user.name);
      yield CommentSuccessState(listDoc: doc);
      add(LoadCommentEvent(id: event.id,isRefresh: true));
    }

    if(event is DeleteCommentEvent){
      yield InitCommentState();
      DataBase().deleteComment(id: event.id,idComment: event.idComment);
      yield CommentSuccessState(listDoc: doc);
      add(LoadCommentEvent(id: event.id,isRefresh: true));
    }
  }

  Future<DocumentSnapshot> getData({String id}) async {
    prefs = await SharedPreferences.getInstance();
    final databaseReference = Firestore.instance;
    var usersRef = databaseReference.collection("post");
    doc = await usersRef.document(id).get();
    return doc;
  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }

  Future<User> getUser() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.get('userId') ?? null;
    user = await DataBase(uid: userId).dataUser();
    return user;
  }
}
