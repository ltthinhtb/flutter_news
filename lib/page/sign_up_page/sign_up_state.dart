import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  SignUpState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class InitSignUpState extends SignUpState {
  @override
  String toString() {
    return 'InitSignUpState{}';
  }
}

class SignUpSuccess extends SignUpState {
  @override
  String toString() {
    return 'SignUpSuccess{}';
  }
}

class SignUpFail extends SignUpState {
  @override
  String toString() {
    return 'SignUpFail{}';
  }
}

class SignUpLoading extends SignUpState {
  @override
  String toString() {
    return 'SignUpLoading{}';
  }
}
