import 'package:equatable/equatable.dart';
import 'package:flutter_news/models/response/user.dart';

class WebViewPageState extends Equatable {
  WebViewPageState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class InitWebViewPageState extends WebViewPageState {
  @override
  String toString() {
    return 'InitWebViewPageState{}';
  }
}

class WebViewPageSuccess extends WebViewPageState {
  final User user;

  WebViewPageSuccess({this.user});
  @override
  String toString() {
    return 'WebViewPageSuccess{}';
  }
}

class WebViewPageFail extends WebViewPageState {
  @override
  String toString() {
    return 'WebViewPageFail{}';
  }
}

class WebViewPageLoading extends WebViewPageState {
  @override
  String toString() {
    return 'WebViewPageLoading{}';
  }
}


