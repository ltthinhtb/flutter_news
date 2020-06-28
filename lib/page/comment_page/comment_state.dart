import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentState extends Equatable {
  CommentState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class CommentSuccessState extends CommentState {
  final DocumentSnapshot listDoc;

  CommentSuccessState({this.listDoc});

  @override
  String toString() {
    return 'CommentSuccessState{doc: $listDoc}';
  }


}

class CommentLoadingState extends CommentState {

  @override
  String toString() {
    return 'CommentLoadingState{}';
  }
}

class InitCommentState extends CommentState {

  @override
  String toString() {
    return 'InitCommentState{}';
  }
}

class CommentFailState extends CommentState {

  @override
  String toString() {
    return 'CommentFailState{}';
  }
}