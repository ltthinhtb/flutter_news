import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  HomePageEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadDataEvent extends HomePageEvent {
  @override
  String toString() {
    return 'LoadDataEvent{}';
  }
}
