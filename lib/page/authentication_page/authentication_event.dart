import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginInGoogle extends AuthenticationEvent {
  @override
  String toString() {
    return 'LoginInGoogle{}';
  }
}

class LoginFacebook extends AuthenticationEvent {
  @override
  String toString() {
    return 'LoginFacebook{}';
  }
}

class LoginInEmailPassWord extends AuthenticationEvent {
  final String email;
  final String password;

  LoginInEmailPassWord(this.email, this.password);

  @override
  String toString() {
    return 'LoginInEmailPassWord{email: $email, password: $password}';
  }
}

class ValidateEmail extends AuthenticationEvent {
  final String email;

  ValidateEmail(this.email);

  @override
  String toString() {
    return 'ValidateEmail{email: $email}';
  }
}
