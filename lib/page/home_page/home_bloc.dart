import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news/models/response/list_new_response.dart';
import 'package:flutter_news/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  ListNewsResponse listNewsResponse;
  SharedPreferences prefs;
  int isDark = 0;
  Data data;

  @override
  // TODO: implement initialState
  HomePageState get initialState => InitState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadDataEvent) {
      yield event.isRefresh ? InitState() : LoadingDataState();
      await getData();
      if (await getOption())
        isDark = 1;
      else
        isDark = 0;
      yield GetDataSuccess(listNewsResponse);
    }
    if (event is SaveRecentEvent) {
      prefs = await SharedPreferences.getInstance();
      String userId = prefs.get('userId') ?? null;
      yield LoadingDataState();
      if (userId == null) {
        add(LoadDataEvent(isRefresh: true));
        yield SaveRecentSuccess(
            title: event.title,
            photo: event.photo,
            url: event.url,
            id: event.id,
            urlOpen: event.urlOpen);
      } else {
        await DataBase(uid: userId).saveRecentNews(
            title: event.title,
            photo: event.photo,
            url: event.url,
            id: event.id);
        add(LoadDataEvent(isRefresh: true));
        yield SaveRecentSuccess(
            title: event.title,
            photo: event.photo,
            url: event.url,
            id: event.id,
        urlOpen: event.urlOpen);
      }
    }
  }

  Future<Object> getData() async {
    var dio = Dio();
    Response response = await dio.get(
        'https://gw.vnexpress.net/ar/get_rule_2?category_id=1001002&limit=100&page=1&data_select=title,article_id,thumbnail_url,share_url,lead,publish_time&fbclid=IwAR3ApQZzINH01eBDgyGx5D8uxjQlVupBzZOiht6HCI12t7At1H8bZTYXTtk');
    listNewsResponse = ListNewsResponse.fromJson(response.data);
    print(listNewsResponse);
    return listNewsResponse;
  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }
}
