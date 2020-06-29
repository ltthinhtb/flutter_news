

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_news/page/home_page/home.dart';
import 'package:flutter_news/page/home_page/home_bloc.dart';
import 'package:flutter_news/page/home_page/home_event.dart';
import 'package:flutter_news/page/webview_page/webview.dart';
import 'package:flutter_news/widget/list_item.dart';
import 'package:flutter_news/widget/list_news_home.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _bloc;
  int x = 3;

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
      child: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is SaveRecentSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewPage(
                        title: state.title,
                        url: state.urlOpen,
                        id: state.id,
                        photo: state.photo)));
          }
        },
        child:
            BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
          if (state is GetDataSuccess) {
            return DefaultTabController(
              length: _bloc.list.length,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(85),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_bloc.isDark == 1 ? "assets/bg_appbar.png" : "assets/bg_appbar_light.png"),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: AppBar(
                      backgroundColor: Color.fromRGBO(255, 255, 255, _bloc.isDark == 1 ? 0 : 0.3),
                      automaticallyImplyLeading: false,
                      title: Container(child: Image.asset('assets/logoAppbar.png', height: 45)),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(25.0),
                        child: TabBar(
                            isScrollable: true,
                            //    indicatorWeight: 6.0,
                            tabs: List<Widget>.generate(_bloc.list.length, (index) {
                              return Tab(
                                //text: _bloc.list[index].category.name,
                                child: Text(_bloc.list[index].category.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                              );
                            })),
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                    children: List<Widget>.generate(_bloc.list.length, (i) {
                  return LiquidPullToRefresh(
                    showChildOpacityTransition: false,
                    onRefresh: () => Future.delayed(Duration.zero)
                        .then((_) => _bloc.add(LoadDataEvent(isRefresh: true))),
                    child: ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      itemCount: _bloc.listNews[i].data.length,
                      separatorBuilder: (context, index1) => Divider(
                        color: Colors.grey,
                      ),
                      itemBuilder: (context, int index) {
                        return (index % 4 == 0)
                            ? InkWell(
                                onTap: () {
                                  _bloc.add(SaveRecentEvent(
                                      id: _bloc
                                          .listNews[i].data[index].articleId,
                                      photo: _bloc
                                          .listNews[i].data[index].thumbnailUrl,
                                      title:
                                          _bloc.listNews[i].data[index].title,
                                      url: _bloc
                                          .listNews[i].data[index].shareUrl,
                                      urlOpen: _bloc.listNews[i].data[index]
                                              .shareUrl +
                                          "?view=app&night_mode=${_bloc.isDark}"));
                                },
                                child: ListNewsHome(
                                  title: _bloc.listNews[i].data[index].title,
                                  thumbnail: _bloc
                                      .listNews[i].data[index].thumbnailUrl,
                                  lead: _bloc.listNews[i].data[index].lead,
                                  category: _bloc.listNews[i].category,
                                ),
                              )
                            : InkWell(
                          onTap: () {
                            _bloc.add(SaveRecentEvent(
                                id: _bloc
                                    .listNews[i].data[index].articleId,
                                photo: _bloc
                                    .listNews[i].data[index].thumbnailUrl,
                                title:
                                _bloc.listNews[i].data[index].title,
                                url: _bloc
                                    .listNews[i].data[index].shareUrl,
                                urlOpen: _bloc.listNews[i].data[index]
                                    .shareUrl +
                                    "?view=app&night_mode=${_bloc.isDark}"));
                          },
                              child: CustomListItem(
                                  title: _bloc.listNews[i].data[index].title,
                                  publishDate: "4 giờ trước",
                                  thumbnail:
                                      _bloc.listNews[i].data[index].thumbnailUrl,
                                ),
                            );
                      },
                    ),
                  );
                })),
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
