import 'package:app_v2/api/config.dart';
import 'package:app_v2/model/tag.dart';
import 'package:app_v2/model/video.dart';
import 'package:app_v2/model/play.dart';
import 'package:dio/dio.dart';

class VideoAPI { 
  //通过id获取video的play
  static Future<Play> getVideoPlay(int id) async {
    final response = await dio.post(
      '/video/watch',
      data: {
        'id': id
      },
    );
    //如果response不是200，会抛出异常，异常为int类型
    if (response.statusCode != 200) {
      throw Exception(response.statusCode);
    }
    return Play.fromJson(response.data);
  }
  //通过id获取video的信息
  static Future<Video> getVideoInfo(int id) async {
    final response = await dio.get(
      '/video/get/info`',
      queryParameters: {
        'id': id
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.statusCode);
    }
    return Video.fromJson(response.data);
  }
}