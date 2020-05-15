import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/page/notification_page/notification_event.dart';
import 'package:flutter_news/page/notification_page/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  BuildContext context;
  Map<String, dynamic> message;

  @override
  // TODO: implement initialState
  NotificationState get initialState => InitNotificationState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadNotificationEvent) {
      yield event.isRefresh
          ? InitNotificationState()
          : NotificationLoadingState();

      yield NotificationSuccessState();
    }
  }
}
