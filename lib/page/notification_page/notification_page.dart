import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/notification_page/notification_bloc.dart';
import 'package:flutter_news/page/notification_page/notification_event.dart';
import 'package:flutter_news/page/notification_page/notification_state.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    _bloc = NotificationBloc();
    _bloc.add(LoadNotificationEvent(isRefresh: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<NotificationBloc,NotificationState>(
        builder: (context,state){
          if(state is NotificationSuccessState)
          return Scaffold(
            appBar: AppBar(
              title: Text('Thông báo'),
            ),
            body: LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: () => Future.delayed(Duration.zero)
                  .then((_) => _bloc.add(LoadNotificationEvent(isRefresh: true))),
              child: ListView(
                children: [
                  ListTile(
                    title: Text(_bloc.message != null ?_bloc.message['notification']['title'] : "hello") ,
                    subtitle: Text(_bloc.message != null ?_bloc.message['notification']['body']: "hello"),
                  ),
                ],
              ),
            ),
          );
          else return Scaffold(
            body: Center(
              child: CircularProgressIndicator()
            ),
          );
        },
      ),
    );
  }
}
