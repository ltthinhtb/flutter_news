import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/notification_page/notification_bloc.dart';
import 'package:flutter_news/page/notification_page/notification_event.dart';
import 'package:flutter_news/page/notification_page/notification_state.dart';
import 'package:flutter_news/page/web_page/webview_page.dart';


import 'package:flutter_news/widget/list_item.dart';
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
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationSuccessState)
            return Scaffold(
              appBar: AppBar(
                title: Text('Thông báo'),
              ),
              body: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                onRefresh: () => Future.delayed(Duration.zero).then(
                    (_) => _bloc.add(LoadNotificationEvent(isRefresh: true))),
                child: state.listDoc.length == 0
                    ? ListView(
                        children: [
                          SizedBox(height: 200,),
                          Center(child: Text('Chưa có thông báo')),
                        ],
                      )
                    : ListView.builder(
                        itemCount: _bloc.listDoc.length,
                        itemBuilder: (context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebViewPage(
//                                          id: int.parse(state.listDoc[index]['id']),
//                                          photo: state.listDoc[index]['photo'],
                                          url: 'https://vnexpress.net/the-gioi/new-york-cau-cuu-${state.listDoc[index]['id']}.html?view=app',
                                          title: state.listDoc[index]['title'])));
                            },
                            child: CustomListItem(
                              title: state.listDoc[index]['title'],
                              author: 'Hello',
                              url:
                                  'https://vnexpress.net/the-gioi/new-york-cau-cuu-${state.listDoc[index]['id']}.html?view=app',
                              publishDate: 'Cách đây 29 phút',
                              category: 'Hôm nay',
                              thumbnail: state.listDoc[index]['photo'],
                            ),
                          );
                        },
                      ),
              ),
            );
          else
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        },
      ),
    );
  }
}
