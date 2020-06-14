import 'package:equatable/equatable.dart';


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

class SaveRecentSuccess extends HomePageState {
  final int id;
  final String title;
  final String url;
  final String photo;
  final String urlOpen;

  SaveRecentSuccess( {this.id, this.title, this.url, this.photo,this.urlOpen});

  @override
  String toString() {
    return 'SaveRecentSuccess{id: $id, title: $title, url: $url, photo: $photo}';
  }
}

class LoadingDataState extends HomePageState {
  @override
  String toString() {
    return 'LoadingDataState{}';
  }
}

class GetDataSuccess extends HomePageState {

  @override
  String toString() {
    return 'GetDataSuccess{response: }';
  }
}
