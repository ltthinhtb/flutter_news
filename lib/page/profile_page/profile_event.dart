import 'package:equatable/equatable.dart';

abstract class ProfileSettingEvent extends Equatable {
  ProfileSettingEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileSettingEvent {
  @override
  String toString() {
    return 'LoadingProfileEvent{}';
  }
}

class LoadSettingEvent extends ProfileSettingEvent {
  @override
  String toString() {
    return 'LoadSettingEvent{}';
  }
}

class LogOut extends ProfileSettingEvent {
  @override
  String toString() {
    return 'LogOut{}';
  }
}
