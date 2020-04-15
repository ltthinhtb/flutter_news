import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class InitAuthenticationState extends AuthenticationState {
  @override
  String toString() {
    return 'InitAuthenticationState{}';
  }
}

class AuthenticationSuccess extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationSuccess{}';
  }
}

class AuthenticationFail extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationFail{}';
  }
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationLoading{}';
  }
}

class ValidateError extends AuthenticationState {
  @override
  String toString() {
    return 'ValidateError{}';
  }
}
