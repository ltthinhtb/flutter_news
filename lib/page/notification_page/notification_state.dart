import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  NotificationState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class NotificationSuccessState extends NotificationState {

  @override
  String toString() {
    return 'NotificationSuccessState{}';
  }
}

class NotificationLoadingState extends NotificationState {

  @override
  String toString() {
    return 'NotificationLoadingState{}';
  }
}

class InitNotificationState extends NotificationState {

  @override
  String toString() {
    return 'InitNotificationState{}';
  }
}

class NotificationFailState extends NotificationState {

  @override
  String toString() {
    return 'NotificationFailState{}';
  }
}