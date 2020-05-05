import 'package:dio/dio.dart';


class NetworkFactory {
  Dio _dio;

  Future<Object> getListNews() async {
    return await requestApi(_dio.get(
        "https://gw.vnexpress.net/ar/get_rule_2?category_id=1001002&limit=10&page=1&data_select=title&fbclid=IwAR1qF9cliUPvjXoZSHOsmDZDN9Am20gc0S9KVl5OiSUqHKnhIjZoJ6cYGd8"));
  }

  Future<Object> requestApi(Future<Response> request) async {
    Response response = await request;
    var data = response.data;
    if (data["status"] == 200)
      return data;
    else if (data["status"] == 202) {
      return data["message"];
    } else
      return data["message"];
  }
}
