import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news/models/response/list_new_response.dart';

import 'recent_list_news.dart';

class RecentListNewPageBloc extends Bloc<RecentListNewPageEvent, RecentListNewPageState> {
  ListNewsResponse _listNewsResponse;
  Data data;

  @override
  // TODO: implement initialState
  RecentListNewPageState get initialState => InitState();

  @override
  Stream<RecentListNewPageState> mapEventToState(RecentListNewPageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadRecentListNewsEvent) {
      yield event.isRefresh ? InitState() : LoadingDataState();
      await getData();
      yield GetDataSuccess(_listNewsResponse);
    }
  }

  Future<Object> getData() async {
    var dio = Dio();
    Response response = await dio.get(
        'https://gw.vnexpress.net/ar/get_rule_2?category_id=1001002&limit=20&page=1&data_select=title,article_id,thumbnail_url,share_url&fbclid=IwAR29hIP81-wOlGGXAhuH0ryuPwsIdEZwyP_K54eiwDuoxgFfySoNa8ry04k');
    _listNewsResponse = ListNewsResponse.fromJson(response.data);
    print(_listNewsResponse);
    return _listNewsResponse;
  }
}
