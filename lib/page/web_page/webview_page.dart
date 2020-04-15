import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  final String title;
  final String url;

  const WebViewPage({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
          child: const Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}
