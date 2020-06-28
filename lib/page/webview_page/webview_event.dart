import 'package:equatable/equatable.dart';

abstract class WebViewPageEvent extends Equatable {
  WebViewPageEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadWebViewEvent extends WebViewPageEvent {
  final bool isRefresh;
  final String id;

  LoadWebViewEvent({this.isRefresh,this.id});

  @override
  String toString() {
    return 'LoadNotificationEvent{isRefresh: $isRefresh}';
  }
}
