import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/home_page/home.dart';
import 'package:flutter_news/page/home_page/home_bloc.dart';
import 'package:flutter_news/page/home_page/home_event.dart';
import 'package:flutter_news/page/web_page/webview_page.dart';

import 'package:flutter_news/widget/list_news_home.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    _bloc = HomePageBloc();
    _bloc.add(LoadDataEvent(isRefresh: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child:
      BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is SaveRecentSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                WebViewPage(
                  title: state.title,
                  url: state.urlOpen,
                  id: state.id,
                  photo: state.photo,
                )));
          }
        },
        child: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is GetDataSuccess) {
                return DefaultTabController(
                  length: 7,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(80.0),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        title: Image.asset('assets/logo.png', height: 70),
                        bottom: TabBar(
                          isScrollable: true,
                          //    indicatorWeight: 6.0,
                          tabs: <Widget>[
                            Tab(
                              child: Container(
                                child: Text('Thế Giới',
                                    style: TextStyle(fontSize: 16.0)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: Text(
                                  'Du Lịch',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: Text(
                                    'Phim', style: TextStyle(fontSize: 16.0)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: Text('Thời Trang',
                                    style: TextStyle(fontSize: 16.0)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child:
                                Text(
                                    'Thể Thao', style: TextStyle(fontSize: 16.0)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child:
                                Text('Dịch Vụ', style: TextStyle(fontSize: 16.0)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child:
                                Text(
                                    'Tình Yêu', style: TextStyle(fontSize: 16.0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        LiquidPullToRefresh(
                          showChildOpacityTransition: false,
                          onRefresh: () =>
                              Future.delayed(Duration.zero)
                                  .then((_) =>
                                  _bloc.add(LoadDataEvent(isRefresh: true))),
                          child: ListView.separated(
                            itemCount: state.response.data.category.listData
                                .length,
                            separatorBuilder: (context, index) =>
                                Divider(
                                  color: Colors.black,
                                ),
                            itemBuilder: (context, int index) {
                              return InkWell(
                                onTap: () {
                                  _bloc.add(SaveRecentEvent(id: state
                                      .response.data.category.listData[index]
                                      .articleId,
                                      photo:state.response.data.category
                                          .listData[index].thumbnailUrl,
                                    title: state
                                        .response.data.category.listData[index]
                                        .title,
                                    url: state
                                        .response.data.category.listData[index]
                                        .shareUrl,
                                    urlOpen: state
                                        .response.data.category.listData[index]
                                        .shareUrl+"?view=app&night_mode=${_bloc.isDark}"
                                  ));
                                },
                                child: ListNewsHome(
                                  title: state
                                      .response.data.category.listData[index]
                                      .title,
                                  thumbnail: state.response.data.category
                                      .listData[index].thumbnailUrl,
                                  lead: state.response.data.category.listData[index].lead,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                );
              } else
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            }),
      ),
    );
  }
}
