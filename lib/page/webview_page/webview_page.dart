import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/authentication_page/authentication.dart';
import 'package:flutter_news/page/comment_page/comment.dart';
import 'package:flutter_news/service/database.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'webview.dart';

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
      this.commentController,
      this.title,
      this.url,
      this.id,
      this.photo})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  WebViewPageBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState

    _bloc = WebViewPageBloc();
    _bloc.add(LoadWebViewEvent(isRefresh: true, id: widget.id.toString()));
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

    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<WebViewPageBloc, WebViewPageState>(
          listener: (context, state) {},
          child: BlocBuilder<WebViewPageBloc, WebViewPageState>(
            builder: (context, state) {
              if (state is WebViewPageLoading)
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              if (state is WebViewPageSuccess) {
                return WebviewScaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_bloc.isDark
                              ? "assets/bg_appbar.png"
                              : "assets/bg_appbar_light.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: AppBar(
                        backgroundColor: Color.fromRGBO(
                            255, 255, 255, _bloc.isDark ? 0 : 0.3),
                      ),
                    ),
                  ),
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
                    offset: Offset(
                        0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
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
                                          builder: (context) =>
                                              AuthenticationPage()));
                                }
                              },
                              child: Container(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 7),
                                      child: Center(
                                          child: state.user == null
                                              ? Icon(
                                                  Icons.person,
                                                  size: 30,
                                                )
                                              : state.user.photoUrl == null
                                                  ? Icon(
                                                      Icons.person,
                                                      size: 30,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(state
                                                              .user.photoUrl),
                                                      radius: 15,
                                                    )
//                                      Image.network(
//                                                  state.user.photoUrl,
//                                                  width: 30,
//                                                  height: 30,
//                                                ),
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
                                    icon: Stack(
                                      children: [
                                        Icon(Icons.message),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 12,
                                                minHeight: 12,
                                              ),
                                              child: Text(
                                                "${_bloc.count}",
                                                style: TextStyle(fontSize: 9),
                                              )),
                                        )
                                      ],
                                    ),
                                    onPressed: () async {
                                      prefs =
                                          await SharedPreferences.getInstance();
                                      bool isLogin =
                                          prefs.get('islogin') ?? false;
                                      if (isLogin) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentPage(
                                                      id: widget.id,
                                                      url: widget.url,
                                                    )));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AuthenticationPage()));
                                      }
                                    }),
                                IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () => share(context)),
                                IconButton(
                                    icon: Icon(Icons.bookmark),
                                    onPressed: () async {
                                      prefs =
                                          await SharedPreferences.getInstance();
                                      bool isLogin =
                                          prefs.get('islogin') ?? false;
                                      if (isLogin) {
                                        String userId =
                                            prefs.get('userId') ?? null;
                                        await DataBase(uid: userId)
                                            .saveLoveNews(
                                          id: widget.id ?? "",
                                          url: widget.url ?? "",
                                          photo: widget.photo ?? "",
                                          title: widget.title ?? "",
                                        );
                                        _displaySnackBar(
                                            context, 'Đã lưu thành công');
                                      } else
                                        _displaySnackBar(
                                            context, 'Bạn cần đăng nhập');
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
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
