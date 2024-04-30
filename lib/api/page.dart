import 'package:app_v2/api/config.dart';
import 'package:app_v2/model/page.dart';

class PageAPI{
  //通过name string来获取page
  static Future<Page> getPageByName(String name) async {
    final response = await dio.get(
      '/page/get',
      queryParameters: {
        'name': name
      },
    );
    if (response.statusCode == 200) {
      return Page.fromJson(response.data);
    } else {
      throw Exception('Failed to load page');
    }
  }
}