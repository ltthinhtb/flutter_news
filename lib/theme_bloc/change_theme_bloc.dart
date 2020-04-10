import 'package:bloc/bloc.dart';
import 'package:flutter_news/theme_bloc/chang_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeBloc extends Bloc<ChangeThemeEvent, ChangeThemeState> {
  SharedPreferences prefs;
  bool optionValue ;

  @override
  ChangeThemeState get initialState => InitThemeState();

  @override
  Stream<ChangeThemeState> mapEventToState(ChangeThemeEvent event) async* {
    if (event is LoadThemeEvent) {
      yield InitThemeState();
      optionValue = await getOption();
      print(optionValue);
      if (!optionValue) {
        yield LightThemeState();
      } else
        yield DarkThemeState();
    }
    if (event is ChooseThemeEvent) {
      yield InitThemeState();
      optionValue = !optionValue;
      _saveOptionValue(optionValue);
      yield ChangeThemeState();
    }
  }

  Future<void> _saveOptionValue(bool optionValue) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme_option', optionValue);
  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }
}
