import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpEmailPassWord extends SignUpEvent {
  final String email;
  final String password;

  SignUpEmailPassWord(this.email, this.password);

  @override
  String toString() {
    return 'SignUpEmailPassWord{email: $email, password: $password}';
  }
}
