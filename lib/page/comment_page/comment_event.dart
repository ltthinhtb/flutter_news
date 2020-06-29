import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  CommentEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadCommentEvent extends CommentEvent {
  final bool isRefresh;
  final String id;

  LoadCommentEvent({this.isRefresh, this.id});

  @override
  String toString() {
    return 'LoadCommentEvent{isRefresh: $isRefresh}';
  }
}

class SaveCommentEvent extends CommentEvent {
  final String userName;
  final String userId;
  final String url;
  final String comment;
  final Timestamp timestamp;
  final String id;

  SaveCommentEvent(
      {this.userName,
      this.userId,
      this.url,
      this.comment,
      this.timestamp,
      this.id});

  @override
  String toString() {
    return 'SaveCommentEvent{userName: $userName, userId: $userId, url: $url, comment: $comment, timestamp: $timestamp}';
  }
}

class DeleteCommentEvent extends CommentEvent {
  final String id;
  final String idComment;

  DeleteCommentEvent({this.id, this.idComment});

  @override
  String toString() {
    return 'DeleteCommentEvent{id: $id, idComment: $idComment}';
  }
}
