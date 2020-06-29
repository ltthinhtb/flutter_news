import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/webview_page/webview.dart';

import 'package:flutter_news/widget/list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'save_list_news.dart';
import 'save_list_news_bloc.dart';

class SaveListNewPage extends StatefulWidget {
  @override
  _SaveListNewPageState createState() => _SaveListNewPageState();
}

class _SaveListNewPageState extends State<SaveListNewPage> {
  SaveListNewPageBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    _bloc = SaveListNewPageBloc();
    _bloc.add(LoadSaveListNewsEvent(isRefresh: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<SaveListNewPageBloc, SaveListNewPageState>(
          builder: (context, state) {
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
                  title: Center( child: Text("Đã đánh dấu         " , style: TextStyle(fontWeight: FontWeight.w500))),
                ),
              ),
            ),
            body: LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: () => Future.delayed(Duration.zero).then(
                  (_) => _bloc.add(LoadSaveListNewsEvent(isRefresh: true))),
              child: state.doc.data['love_news'] == null
                  ? Center(
                      child: Text('Bạn chưa lưu bài nào cả'),
                    )
                  : ListView.separated(
                      itemCount: state.doc.data['love_news'].length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                      itemBuilder: (context, int index) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Chia sẻ',
                              color: Colors.black45,
                              icon: Icons.more_horiz,
                            ),
                            IconSlideAction(
                              onTap: () {},
                              caption: 'Xóa bỏ',
                              color: Colors.red,
                              icon: Icons.delete,
                            ),
                          ],
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebViewPage(
                                          id: state.doc.data['love_news'][index]
                                              ['love_id'],
                                          photo: state.doc.data['love_news']
                                              [index]['love_photo'],
                                          url: state.doc.data['recent_news']
                                                  [index]['url'] +
                                              "?view=app&night_mode=${_bloc.isDark}",
                                          title: state.doc.data['love_news']
                                              [index]['love_title'])));
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              child:  CustomListItem(
                                  title: state.doc.data['love_news'][index]
                                  ['love_title'],
                                  publishDate: '15/4/2020',
                                  thumbnail: state.doc.data['love_news'][index]
                                  ['love_photo']),
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
