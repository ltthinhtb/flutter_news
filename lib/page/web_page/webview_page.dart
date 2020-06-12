import 'package:flutter/material.dart';
import 'package:flutter_news/service/database.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

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
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    _displaySnackBar(BuildContext context) {
      final snackBar = SnackBar(content: Text('Đã lưu thành công'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: WebviewScaffold(
          url: url,
          userAgent: kAndroidUserAgent,
          javascriptChannels: jsChannels,
          allowFileURLs: true,
          withJavascript: true,
          withOverviewMode: true,
          useWideViewPort: true,
          enableAppScheme: true,
          mediaPlaybackRequiresUserGesture: false,
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
                      _displaySnackBar(context);
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
