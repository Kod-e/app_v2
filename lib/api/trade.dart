import 'dart:convert';

import 'package:app_v2/api/config.dart';
import 'package:app_v2/model/trade.dart';
class UserAPI{
    static Future<Trade> getPageByName(int day,String method) async {
    final response = await dio.post(
      '/trade/get',
      data: {
        'day': day,
        'method': method,
        'from' : 'app_v2'
      },
    );
    if (response.statusCode == 200) {
      return Trade.fromJson(response.data);
    } else {
      throw Exception('Failed to get trade');
    }
  }
}