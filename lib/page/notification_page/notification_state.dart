import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  NotificationState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class NotificationSuccessState extends NotificationState {
  final List<DocumentSnapshot> listDoc;

  NotificationSuccessState(this.listDoc);

  @override
  String toString() {
    return 'NotificationSuccessState{doc: $listDoc}';
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