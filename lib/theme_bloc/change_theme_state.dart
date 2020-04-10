import 'package:equatable/equatable.dart';


class ChangeThemeState extends Equatable {
  ChangeThemeState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class InitThemeState extends ChangeThemeState {
  @override
  String toString() {
    return 'InitThemeState{}';
  }
}

class DarkThemeState extends ChangeThemeState {
  @override
  String toString() {
    return 'DarkThemeState{}';
  }
}

class LightThemeState extends ChangeThemeState {
  @override
  String toString() {
    return 'LightThemeState{}';
  }
}
