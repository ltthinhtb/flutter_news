import 'dart:convert';
import 'package:flutter_news/models/response/news_response.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/models/response/list_category_response.dart';
import 'package:flutter_news/models/response/list_new_response.dart';
import 'package:flutter_news/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  ListNewsResponse listNewsResponse;
  List<NewsResponse> listNews = List();
  SharedPreferences prefs;
  List<ListCategory> list = List();

  int isDark = 0;

  @override
  // TODO: implement initialState
  HomePageState get initialState => InitState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadDataEvent) {
      yield event.isRefresh ? InitState() : LoadingDataState();
      String data = await rootBundle.loadString("assets/category.json");
      final jsonResult = json.decode(data);
      CategoryResponse response = CategoryResponse.fromJson(jsonResult);
      list = response.listCategory;
      for (int index = 0; index < list.length; index++) {
        listNews.add(await getDataBase(id: list[index].category.categoryId));
      }
      for (int index = 0; index < list.length; index++) {
        listNews[index].category = list[index].category.name;
      }
      if (await getOption())
        isDark = 1;
      else
        isDark = 0;
      yield GetDataSuccess();
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

//  Future<Object> getData() async {
//    var dio = Dio();
//    Response response = await dio.get(
//        'https://gw.vnexpress.net/ar/get_rule_2?category_id=1001002&limit=50&page=1&data_select=title,article_id,thumbnail_url,share_url,lead,publish_time&fbclid=IwAR3ApQZzINH01eBDgyGx5D8uxjQlVupBzZOiht6HCI12t7At1H8bZTYXTtk');
//    listNewsResponse = ListNewsResponse.fromJson(response.data);
//    return listNewsResponse;
//  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }

  Future<NewsResponse> getDataBase({String id}) async {
    var url =
        'https://gw.vnexpress.net/ar/get_rule_2?category_id=$id&limit=50&page=1&data_select=title,article_id,thumbnail_url,share_url,lead,publish_time&fbclid=IwAR3ApQZzINH01eBDgyGx5D8uxjQlVupBzZOiht6HCI12t7At1H8bZTYXTtk';
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var dataCategory = jsonResponse['data'][id];
    NewsResponse newsResponse = NewsResponse.fromJson(dataCategory);
    return newsResponse;
  }
}
