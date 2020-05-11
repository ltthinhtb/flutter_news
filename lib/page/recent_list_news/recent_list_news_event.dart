import 'package:equatable/equatable.dart';

abstract class RecentListNewPageEvent extends Equatable {
  RecentListNewPageEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadRecentListNewsEvent extends RecentListNewPageEvent {
  final bool isRefresh;

  LoadRecentListNewsEvent({this.isRefresh});

  @override
  String toString() {
    return 'LoadDataEvent{isRefresh: $isRefresh}';
  }
}
