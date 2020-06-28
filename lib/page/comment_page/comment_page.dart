import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  CommentBloc _bloc;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    print(widget.id);
    flutterWebViewPlugin.close();
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
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                    title: Text(
                      "Bình luận",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
              ),
              body: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                onRefresh: () => Future.delayed(Duration.zero)
                    .then((_) => _bloc.add(LoadCommentEvent(isRefresh: true))),
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
                              padding: EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: Container(
                                    height: 50,
                                    width: 50,
                                    child: state.listDoc['comment'][index]
                                                ['url'] !=
                                            null
                                        ? Image.network(state.listDoc['comment']
                                            [index]['url'])
                                        : Icon(Icons.person)),
                                title: Text(state.listDoc['comment'][index]
                                    ['comment_title']),
                                subtitle: Container(
                                  margin: EdgeInsets.only(right: 40),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${timestamp.toDate().day}' +
                                          "-${timestamp.toDate().month}" +
                                          "-${timestamp.toDate().year}"),
                                      Text(state.listDoc['comment'][index]
                                          ['userName'])
                                    ],
                                  ),
                                ),
                                trailing: state.listDoc['comment'][index]
                                            ['userId'] ==
                                        _bloc.userId
                                    ? Container(
                                        child: Icon(Icons.more_horiz),
                                      )
                                    : Container(child: Icon(Icons.more_horiz)),
                              ));
                        },
                      ),
              ),
              bottomNavigationBar: Transform.translate(
                offset:
                    Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
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
                              hintText: "Bình luận của bạn...",
                              prefixIcon: Icon(
                                Icons.person,
                                size: 30,
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
                            child: Text(
                              'Gửi',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                        )
                      ],
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
}
