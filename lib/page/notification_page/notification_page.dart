import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/webview_page/webview.dart';

import 'package:flutter_news/widget/list_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'notification.dart';

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
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                    title: Text(
                  "Thông báo",
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
              ),
              body: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                onRefresh: () => Future.delayed(Duration.zero).then(
                    (_) => _bloc.add(LoadNotificationEvent(isRefresh: true))),
                child: !_bloc.isLogin
                    ? ListView(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Center(child: Text('Bạn cần đăng nhập')),
                        ],
                      )
                    : state.listDoc.length == 0
                        ? ListView(
                            children: [
                              SizedBox(
                                height: 200,
                              ),
                              Center(child: Text('Chưa có thông báo')),
                            ],
                          )
                        : ListView.builder(
                            itemCount: _bloc.listDoc.length,
                            itemBuilder: (context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebViewPage(
                                              id: int.parse(
                                                  state.listDoc[index]['id']),
                                              photo: state.listDoc[index]
                                                  ['photo'],
                                              url: state.listDoc[index]['url'] +
                                                  "?view=app&night_mode=${_bloc.isDark}",
                                              title: state.listDoc[index]
                                                  ['title'])));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: CustomListItem(
                                    title: state.listDoc[index]['title'],
                                    author: 'Hello',
                                    publishDate: 'Cách đây 29 phút',
                                    category: 'Hôm nay',
                                    thumbnail: state.listDoc[index]['photo'],
                                  ),
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
