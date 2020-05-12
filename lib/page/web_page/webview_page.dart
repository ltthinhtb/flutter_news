import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class WebViewPage extends StatelessWidget {
  final TextEditingController commentController;
  final String title;
  final String url;

  const WebViewPage(
      {Key key,
      @required this.url,
      @required this.title,
      this.commentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                height: 40,
                width: 230,
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
              IconButton(icon: Icon(Icons.bookmark), onPressed: () {})
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
