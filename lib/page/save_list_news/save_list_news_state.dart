import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class SaveListNewPageState extends Equatable {
  SaveListNewPageState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitState extends SaveListNewPageState {
  @override
  String toString() {
    return 'InitState{}';
  }
}

class DeleteSuccess extends SaveListNewPageState {
  final String msg;

  DeleteSuccess(this.msg);

  @override
  String toString() {
    return 'DeleteSuccess{msg: $msg}';
  }
}

class LoadingDataState extends SaveListNewPageState {
  @override
  String toString() {
    return 'LoadingDataState{}';
  }
}

class GetDataSuccess extends SaveListNewPageState {
  final DocumentSnapshot doc;

  GetDataSuccess(this.doc);

  @override
  String toString() {
    return 'GetDataSuccess{}';
  }
}
