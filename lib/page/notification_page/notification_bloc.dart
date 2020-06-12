import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/page/notification_page/notification_event.dart';
import 'package:flutter_news/page/notification_page/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  BuildContext context;
  List<DocumentSnapshot> listDoc;

  @override
  // TODO: implement initialState
  NotificationState get initialState => InitNotificationState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadNotificationEvent) {
      yield event.isRefresh ? InitNotificationState() :  NotificationLoadingState();
      await getData();
      yield NotificationSuccessState(listDoc);
    }

  }
  Future<List<DocumentSnapshot>> getData() async {
    final QuerySnapshot result =
    await Firestore.instance.collection('notification').getDocuments();
    listDoc = result.documents;
    print(listDoc.length);
    return listDoc;
  }
}