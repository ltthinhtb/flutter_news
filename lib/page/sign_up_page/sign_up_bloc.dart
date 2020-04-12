import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_event.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_state.dart';
import 'package:flutter_news/service/auth_service.dart';
import 'package:flutter_news/service/database.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthService authService = AuthService();
  final CollectionReference userCollection =
  Firestore.instance.collection("users");

  @override
  // TODO: implement initialState
  SignUpState get initialState => InitSignUpState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SignUpEmailPassWord) {
      yield SignUpLoading();
      try {
        String _name = event.name;
        String _surName = event.surName;
        String _email = event.email;
        String _password = event.password;
        String id = await authService.signUpWithEmail(
            email: _email, password: _password);
        await DataBase(uid: id).userCreate(_name, _surName, _email);
        yield SignUpSuccess();
      } catch (e) {
        yield SignUpFail();
      }
    }
  }


}

