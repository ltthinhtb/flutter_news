import 'package:equatable/equatable.dart';

abstract class CovidPageEvent extends Equatable {
  CovidPageEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadCovidDataEvent extends CovidPageEvent {
  final bool isRefresh;

  LoadCovidDataEvent({this.isRefresh});

  @override
  String toString() {
    return 'LoadDataEvent{isRefresh: $isRefresh}';
  }
}

class SaveRecentEvent extends CovidPageEvent {
  final String title;
  final String url;
  final String photo;
  final int id;

  SaveRecentEvent(this.title, this.url, this.photo, this.id);

  @override
  String toString() {
    return 'SaveRecentEvent{title: $title, url: $url, photo: $photo, id: $id}';
  }


}
