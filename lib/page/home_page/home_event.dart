import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  HomePageEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadDataEvent extends HomePageEvent {
  final bool isRefresh;

  LoadDataEvent({this.isRefresh});

  @override
  String toString() {
    return 'LoadDataEvent{isRefresh: $isRefresh}';
  }
}

class SaveRecentEvent extends HomePageEvent {
  final String title;
  final String url;
  final String photo;
  final int id;
  final String urlOpen;
  final String category;

  SaveRecentEvent( {this.title, this.url, this.photo, this.id,this.urlOpen,this.category});

  @override
  String toString() {
    return 'SaveRecentEvent{title: $title, url: $url, photo: $photo, id: $id, urlOpen: $urlOpen}';
  }
}
