import 'package:equatable/equatable.dart';

abstract class ChangeThemeEvent extends Equatable {
  ChangeThemeEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadThemeEvent extends ChangeThemeEvent {
  @override
  String toString() {
    return 'LoadThemeEvent{}';
  }
}

class ChooseThemeEvent extends ChangeThemeEvent {
  @override
  String toString() {
    return 'ChooseThemeEvent{}';
  }
}
