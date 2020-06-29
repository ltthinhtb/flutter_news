
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_news/page/recent_list_news/recent_list_news.dart';
import 'package:flutter_news/page/webview_page/webview.dart';



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
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_bloc.isDark == 1 ? "assets/bg_appbar.png" : "assets/bg_appbar_light.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: AppBar(
                  backgroundColor: Color.fromRGBO(255, 255, 255, _bloc.isDark == 1 ? 0 : 0.3),
                  title: Center( child: Text("Đọc gần đây         " , style: TextStyle(fontWeight: FontWeight.w500))),
                ),
              ),
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
                                  url: state.doc.data['recent_news'][index]['url']+"?view=app&night_mode=${_bloc.isDark}",
                                  title: state.doc.data['recent_news'][index]['title'])));
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: CustomListItem(
                        title:  state.doc.data['recent_news'][index]['title'],
                        publishDate: '15/4/2020',
                        thumbnail: state.doc.data['recent_news'][index]['photo'],
                      ),
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
