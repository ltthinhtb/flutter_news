import 'package:equatable/equatable.dart';
import 'package:flutter_news/models/response/list_new_response.dart';

abstract class HomePageState extends Equatable {
  HomePageState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitState extends HomePageState {
  @override
  String toString() {
    return 'InitState{}';
  }
}

class LoadingDataState extends HomePageState {
  @override
  String toString() {
    return 'LoadingDataState{}';
  }
}

class GetDataSuccess extends HomePageState {
  final ListNewsResponse response;

  GetDataSuccess(this.response);

  @override
  String toString() {
    return 'GetDataSuccess{response: $response}';
  }
}
