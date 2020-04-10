import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/authentication_page/authentication.dart';
import 'package:flutter_news/service/AuthService.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthService authService = AuthService();
  BuildContext context;

  @override
  // TODO: implement initialState
  AuthenticationState get initialState => InitAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoginInGoogle) {
      yield AuthenticationLoading();
      try {
        await authService.signInWithGoogle();
        yield AuthenticationSuccess();
      } catch (e) {
        yield AuthenticationFail();
      }
    }
    if (event is LoginInEmailPassWord) {
      yield AuthenticationLoading();
      String email = event.email;
      String password = event.password;
      try {
        await authService.SignInWithEmail(email, password);
        yield AuthenticationSuccess();
      } catch (e) {
        yield AuthenticationFail();
      }
    }
  }
}
