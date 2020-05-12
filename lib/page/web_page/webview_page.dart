import 'package:flutter/material.dart';
import 'package:flutter_news/service/database.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebViewPage extends StatelessWidget {
  final TextEditingController commentController;
  final String title;
  final String url;
  final int id;
  final String photo;

  const WebViewPage(
      {Key key,
      @required this.url,
      @required this.title,
      this.commentController,
      this.id,
      this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    return Scaffold(
      body: WebviewScaffold(
        url: url,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
            child: const Center(
          child: CircularProgressIndicator(),
        )),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
              SizedBox(
                width: 5,
              ),
              IconButton(
                  icon: Icon(Icons.share), onPressed: () => share(context)),
              SizedBox(
                width: 5,
              ),
              IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () async {
                    prefs = await SharedPreferences.getInstance();
                    String userId = prefs.get('userId') ?? null;
                    if (userId != null) {
                      await DataBase(uid: userId).saveLoveNews(
                        id: id,
                        url: url,
                        photo: photo,
                        title: title,
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(url,
        subject: title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
