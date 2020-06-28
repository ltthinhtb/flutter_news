import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/page/authentication_page/authentication.dart';
import 'package:flutter_news/page/comment_page/comment.dart';
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

class WebViewPage extends StatefulWidget {
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
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    flutterWebviewPlugin.launch(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    _displaySnackBar(BuildContext context, String msg) {
      final snackBar = SnackBar(content: Text(msg));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    share(BuildContext context) {
      final RenderBox box = context.findRenderObject();
      Share.share(widget.url,
          subject: widget.title,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: WebviewScaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: AppBar()),
          url: widget.url,
          userAgent: kAndroidUserAgent,
          javascriptChannels: jsChannels,
          allowFileURLs: true,
          withJavascript: true,
          useWideViewPort: true,
          mediaPlaybackRequiresUserGesture: false,
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          bottomNavigationBar: Transform.translate(
            offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
            child: BottomAppBar(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        prefs = await SharedPreferences.getInstance();
                        bool isLogin = prefs.get('islogin') ?? false;
                        if (isLogin) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentPage(
                                        id: widget.id,
                                        url: widget.url,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthenticationPage()));
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            ),
                            Center(child: Text('Bình luận của bạn'))
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () => share(context)),
                        IconButton(
                            icon: Icon(Icons.bookmark),
                            onPressed: () async {
                              prefs = await SharedPreferences.getInstance();
                              bool isLogin = prefs.get('islogin') ?? false;
                              if (isLogin) {
                                String userId = prefs.get('userId') ?? null;
                                await DataBase(uid: userId).saveLoveNews(
                                  id: widget.id ?? "",
                                  url: widget.url ?? "",
                                  photo: widget.photo ?? "",
                                  title: widget.title ?? "",
                                );
                                _displaySnackBar(context, 'Đã lưu thành công');
                              } else
                                _displaySnackBar(context, 'Bạn cần đăng nhập');
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          initialChild: Container(
              child: const Center(
            child: CircularProgressIndicator(),
          )),
        ),
      ),
    );
  }
}
