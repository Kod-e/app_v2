import 'package:app_v2/api/config.dart';
import 'package:app_v2/model/tag.dart';
import 'package:app_v2/model/video.dart';

class TagAPI {
  //通过id获取tag的data
  static Future<Tag> getTagData(int id) async {
    final response = await dio.get(
      '/tag/get/data',
      queryParameters: {
        'id': id
      },
    );
    return Tag.fromJson(response.data);
  }

  
  //通过id获得tag的video，id为必选，page和page_count为可选
  static Future<List<Video>> getTagVideos(int id, {int? page, int? pageCount}) async {
    Map<String, dynamic> queryParameters = {'id': id};
    if (page != null) {
      queryParameters['page'] = page;
    }
    if (pageCount != null) {
      queryParameters['page_count'] = pageCount;
    }

    final response = await dio.get(
      '/tag/get/data/video',
      queryParameters: queryParameters,
    );
    return (response.data['videos'] as List).map((e) => Video.fromJson(e)).toList();
  }

  //通过id获得tag的tags，id为必选，page和page_count为可选
  static Future<List<Tag>> getTagTags(int id, {int? page, int? pageCount}) async {
    Map<String, dynamic> queryParameters = {'id': id};
    if (page != null) {
      queryParameters['page'] = page;
    }
    if (pageCount != null) {
      queryParameters['page_count'] = pageCount;
    }

    final response = await dio.get(
      '/tag/get/data/tag',
      queryParameters: queryParameters,
    );
    return (response.data['tags'] as List).map((e) => Tag.fromJson(e)).toList();
  }
  //通过id获得子项目的数量
  static Future<Map<String,dynamic>> getTagCount(int id) async {
    final response = await dio.get(
      '/tag/get/count',
      queryParameters: {
        'id': id
      },
    );
    return response.data;
  }
} 
