

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_event.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_state.dart';
import 'package:flutter_news/service/AuthService.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthService authService = AuthService();

  @override
  // TODO: implement initialState
  SignUpState get initialState => InitSignUpState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SignUpEmailPassWord) {
      yield SignUpLoading();
      try {
        String _email = event.email;
        String _password = event.password;
        await authService.signUpWithEmail(email: _email, password: _password);
        yield SignUpSuccess();
      } catch (e) {
        yield SignUpFail();
      }
    }
  }
}
