
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/recent_list_news/recent_list_news.dart';
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
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Tìm kiếm...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              preferredSize: Size(
                MediaQuery.of(context).size.width,
                60.0,
              ),
            ),
            body: LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: () => Future.delayed(Duration.zero).then(
                      (_) => _bloc.add(LoadRecentListNewsEvent(isRefresh: true))),
              child: ListView.separated(
                itemCount: state.response.data.category.listData.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemBuilder: (context, int index) {
                  return CustomListItem(
                    title: state.response.data.category.listData[index].title,
                    author : 'Hello',
                    url:
                        'https://vnexpress.net/the-gioi/new-york-cau-cuu-${state.response.data.category.listData[index].articleId}.html',
                    publishDate: '15/4/2020',
                    category: 'Việt Cộng',
                    thumbnail:
                        state.response.data.category.listData[index].thumbnailUrl,
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
