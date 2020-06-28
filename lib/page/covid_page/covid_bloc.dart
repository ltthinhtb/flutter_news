import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news/models/response/covid_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';


import 'covid.dart';

class CovidPageBloc extends Bloc<CovidPageEvent, CovidPageState> {
  CovidResponse covidResponse;
  SharedPreferences prefs;
  List<TG> tG;
  List<VN> vN;
  bool isDark;

  @override
  // TODO: implement initialState
  CovidPageState get initialState => InitState();

  @override
  Stream<CovidPageState> mapEventToState(CovidPageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadCovidDataEvent) {
      yield event.isRefresh ? InitState() : LoadingDataState();
      await getData();
      isDark = await getOption();
      yield GetDataSuccess(covidResponse);
    }
  }
  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }
  Future<Object> getData() async {
    var dio = Dio();
    Response response = await dio.get(
        'https://ncovi.vnpt.vn/thongtindichbenh_v2');
    covidResponse = CovidResponse.fromJson(response.data);
    tG = covidResponse.data.tG;
    vN = covidResponse.data.vN;
    return covidResponse;
  }
}
