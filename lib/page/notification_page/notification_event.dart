import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  NotificationEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadNotificationEvent extends NotificationEvent {
  final bool isRefresh;

  LoadNotificationEvent({this.isRefresh});

  @override
  String toString() {
    return 'LoadNotificationEvent{isRefresh: $isRefresh}';
  }
}