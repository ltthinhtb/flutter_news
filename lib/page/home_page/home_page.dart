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
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Image.asset('assets/logo.png', height: 70),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(30.0),
                    child: TabBar(
                        indicatorColor: Colors.red,
                        isScrollable: true,
                        //    indicatorWeight: 6.0,
                        tabs: List<Widget>.generate(_bloc.list.length, (index) {
                          return Tab(
                            text: _bloc.list[index].category.name,
                          );
                        })),
                  ),
                ),
                body: TabBarView(
                    children: List<Widget>.generate(_bloc.list.length, (i) {
                  return LiquidPullToRefresh(
                    showChildOpacityTransition: false,
                    onRefresh: () => Future.delayed(Duration.zero)
                        .then((_) => _bloc.add(LoadDataEvent(isRefresh: true))),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: _bloc.listNews[i].data.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            _bloc.add(SaveRecentEvent(
                                id: _bloc.listNews[i].data[index].articleId,
                                photo: _bloc.listNews[i].data[index].thumbnailUrl,
                                title: _bloc.listNews[i].data[index].title,
                                url: _bloc.listNews[i].data[index].shareUrl,
                                urlOpen: _bloc.listNews[i].data[index].shareUrl +
                                    "?view=app&night_mode=${_bloc.isDark}"));
                          },
                          child: ListNewsHome(
                            title: _bloc.listNews[i].data[index].title,
                            thumbnail: _bloc.listNews[i].data[index].thumbnailUrl,
                            lead: _bloc.listNews[i].data[index].lead,
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
