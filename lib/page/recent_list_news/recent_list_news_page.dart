
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/recent_list_news/recent_list_news.dart';
import 'package:flutter_news/page/web_page/webview_page.dart';
import 'package:flutter_news/widget/list_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'recent_list_news_bloc.dart';

class RecentListNewPage extends StatefulWidget {
  @override
  _RecentListNewPageState createState() => _RecentListNewPageState();
}

class _RecentListNewPageState extends State<RecentListNewPage> {
  RecentListNewPageBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    _bloc = RecentListNewPageBloc();
    _bloc.add(LoadRecentListNewsEvent(isRefresh: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child:
          BlocBuilder<RecentListNewPageBloc, RecentListNewPageState>(builder: (context, state) {
        if (state is GetDataSuccess)
          return Scaffold(
            appBar: AppBar(
              title: Text('Tin đã xem'),
            ),
            body: LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: () => Future.delayed(Duration.zero).then(
                      (_) => _bloc.add(LoadRecentListNewsEvent(isRefresh: true))),
              child: state.doc.data['recent_news'] == null ? Center(child: Text('Bạn chưa xem bài nào cả'),)
                  : ListView.separated(
                itemCount: state.doc.data['recent_news'].length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                id: state.doc.data['recent_news'][index]['id'],
                                photo: state.doc.data['recent_news'][index]['photo'],
                                  url: 'https://vnexpress.net/the-gioi/new-york-cau-cuu-${state.doc.data['recent_news'][index]['id']}.html',
                                  title: state.doc.data['recent_news'][index]['title'])));
                    },
                    child: CustomListItem(
                      title:  state.doc.data['recent_news'][index]['title'],
                      author : 'Hello',
                      url:
                      'https://vnexpress.net/the-gioi/new-york-cau-cuu-${state.doc.data['recent_news'][index]['id']}.html',
                      publishDate: '15/4/2020',
                      category: 'Việt Cộng',
                      thumbnail: state.doc.data['recent_news'][index]['photo'],
                    ),
                  );
                },
              ),
            ),
          );
        else
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }),
    );
  }
}
