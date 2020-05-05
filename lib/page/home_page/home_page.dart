
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/home_page/home.dart';
import 'package:flutter_news/page/home_page/home_bloc.dart';
import 'package:flutter_news/page/home_page/home_event.dart';
import 'package:flutter_news/widget/list_item.dart';

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
    _bloc.add(LoadDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child:
          BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
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
            body: ListView.separated(
              itemCount: state.response.data.category.listData.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemBuilder: (context, int index) {
                return CustomListItem(
                  title: state.response.data.category.listData[index].title,
                  subtitle: 'Hello',
                  url:
                      'https://vnexpress.net/the-gioi/new-york-cau-cuu-${state.response.data.category.listData[index].articleId}.html',
                  publishDate: '15/4/2020',
                  category: 'Việt Cộng',
                  thumbnail:
                      state.response.data.category.listData[index].thumbnailUrl,
                );
              },
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
