import 'package:equatable/equatable.dart';

abstract class SaveListNewPageEvent extends Equatable {
  SaveListNewPageEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadSaveListNewsEvent extends SaveListNewPageEvent {
  final bool isRefresh;

  LoadSaveListNewsEvent({this.isRefresh});

  @override
  String toString() {
    return 'LoadDataEvent{isRefresh: $isRefresh}';
  }
}
