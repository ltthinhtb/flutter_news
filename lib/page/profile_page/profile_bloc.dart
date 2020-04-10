import 'package:bloc/bloc.dart';
import 'package:flutter_news/service/AuthService.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'profile.dart';

class ProfileSettingBloc
    extends Bloc<ProfileSettingEvent, ProfileSettingState> {
  SharedPreferences prefs;
  bool optionValue;
  String userName = "";
  AuthService authService = AuthService();
  bool isLogin;

  @override
  ProfileSettingState get initialState => InitProfileSettingState();

  @override
  Stream<ProfileSettingState> mapEventToState(
      ProfileSettingEvent event) async* {
    if (event is LoadProfileEvent) {
      yield LoadingDataState();
      isLogin = await authService.checkLogin();
      print('trang thai là $isLogin');
      if (isLogin) {
        userName = await getUser();
        print(userName);
      } else
        userName = "";
      optionValue = await getOption();
      yield DataSuccessState();
    }

    if (event is LogOut) {
      yield InitProfileSettingState();
      await authService.signOut();
      yield LogOutSuccess();
    }

  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }

  Future<String> getUser() async {
    prefs = await SharedPreferences.getInstance();
    String user = prefs.get('email') ?? false;
    return user;
  }
}
