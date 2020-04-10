import 'package:equatable/equatable.dart';

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
  @override
  String toString() {
    return 'SuccessDataState{}';
  }
}
