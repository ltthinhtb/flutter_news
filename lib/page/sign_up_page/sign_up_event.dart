import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpEmailPassWord extends SignUpEvent {
  final String name;
  final String surName;
  final String email;
  final String password;

  SignUpEmailPassWord(this.name, this.surName, this.email, this.password);

  @override
  String toString() {
    return 'SignUpEmailPassWord{name: $name, surName: $surName, email: $email, password: $password}';
  }
}
