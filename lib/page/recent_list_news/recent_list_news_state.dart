import 'package:equatable/equatable.dart';
import 'package:flutter_news/models/response/list_new_response.dart';

abstract class RecentListNewPageState extends Equatable {
  RecentListNewPageState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitState extends RecentListNewPageState {
  @override
  String toString() {
    return 'InitState{}';
  }
}

class LoadingDataState extends RecentListNewPageState {
  @override
  String toString() {
    return 'LoadingDataState{}';
  }
}

class GetDataSuccess extends RecentListNewPageState {
  final ListNewsResponse response;

  GetDataSuccess(this.response);

  @override
  String toString() {
    return 'GetDataSuccess{response: $response}';
  }
}
