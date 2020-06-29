import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Icon/icon_tab_icons.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'comment.dart';

class CommentPage extends StatefulWidget {
  final int id;
  final String url;

  const CommentPage({Key key, this.id, this.url}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  CommentBloc _bloc;

  @override
  void initState() {
    flutterWebViewPlugin.hide();
    _bloc = CommentBloc();
    _bloc.add(LoadCommentEvent(isRefresh: true, id: widget.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();

    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentSuccessState)
            return WillPopScope(
              onWillPop: () => popToRefresh(context),
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_bloc.isDark == 1
                            ? "assets/bg_appbar.png"
                            : "assets/bg_appbar_light.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: AppBar(
//                      leading: new IconButton(
//                        icon: new Icon(Icons.arrow_back),
//                        onPressed: () {
//                          FlutterWebviewPlugin().show();
//                          Navigator.of(context).pop();
//                        },
//                      ),
                      backgroundColor: Color.fromRGBO(
                          255, 255, 255, _bloc.isDark == 1 ? 0 : 0.3),
                      title: Center(
                          child: Text("Bình luận        ",
                              style: TextStyle(fontWeight: FontWeight.w500))),
                    ),
                  ),
                ),
                body: LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  onRefresh: () => Future.delayed(Duration.zero).then(
                      (_) => _bloc.add(LoadCommentEvent(isRefresh: true))),
                  child: state.listDoc.data == null
                      ? ListView(
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Center(child: Text('Chưa có bình luận nào')),
                          ],
                        )
                      : ListView.builder(
                          itemCount: state.listDoc['comment'].length,
                          itemBuilder: (context, int index) {
                            Timestamp timestamp =
                                state.listDoc['comment'][index]['timestamp'];
                            return Container(
                                padding: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[300],
                                            width: 1.0))),
                                child: ListTile(
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      child: state.listDoc['comment'][index]
                                                  ['url'] !=
                                              null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                state.listDoc['comment'][index]
                                                    ['url'],
                                              ),
                                              radius: 15,
                                            )
                                          : Icon(Icons.person)),
                                  title: Text(state.listDoc['comment'][index]
                                      ['comment_title']),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(right: 40),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '' +
                                              state.listDoc['comment'][index]
                                                  ['userName'] +
                                              ' | ',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        Text(
                                          '' +
                                              '${timestamp.toDate().day}' +
                                              "-${timestamp.toDate().month}" +
                                              "-${timestamp.toDate().year}",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: IconButton(icon: Icon(Icons.more_horiz), onPressed: (){
                                  }),
                                ));
                          },
                        ),
                ),
                bottomNavigationBar: Transform.translate(
                  offset: Offset(
                      0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
                  child: BottomAppBar(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 200,
                            child: TextField(
                              controller: commentController,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    "Bình luận của bạn...                         ",
                                prefixIcon: Icon(
                                  IconTab.user,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                _bloc.add(SaveCommentEvent(
                                    id: widget.id.toString(),
                                    comment: commentController.text));
                              },
                              child: Icon(
                                Icons.send,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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

  // ignore: missing_return
  Future<Null> popToRefresh(BuildContext context) {
    FlutterWebviewPlugin().show();
    Navigator.of(context).pop();
  }
}
