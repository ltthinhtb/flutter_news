import 'package:equatable/equatable.dart';
import 'package:flutter_news/models/response/user.dart';


class ProfileSettingState extends Equatable {
  ProfileSettingState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class InitProfileSettingState extends ProfileSettingState {
  @override
  String toString() {
    return 'InitProfileSettingState{}';
  }
}

class ProfileLoadingState extends ProfileSettingState {
  @override
  String toString() {
    return 'ProfileLoadingState{}';
  }
}

class LoadingDataState extends ProfileSettingState {
  @override
  String toString() {
    return 'LoadingDataSuccess{}';
  }
}

class LogOutSuccess extends ProfileLoadingState {
  @override
  String toString() {
    return 'LogOutSuccess{}';
  }
}

class DataSuccessState extends ProfileSettingState {
  final bool optionValue;
  final User user;

  DataSuccessState(this.optionValue, this.user);

  @override
  String toString() {
    return 'DataSuccessState{optionValue: $optionValue, user: $user}';
  }
}
