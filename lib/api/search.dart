import 'package:app_v2/api/config.dart';
import 'package:app_v2/model/search.dart';


class SearchAPI {
  //搜索内容
  static Future<Search> search(String keyword) async {
    final response = await dio.get(
      '/search',
      queryParameters: {
        'data': keyword
      },
    );
    //返回一个search model
    return Search.fromJson(response.data);
  } 
}