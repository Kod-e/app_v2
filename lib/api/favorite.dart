import 'package:app_v2/api/config.dart';
import 'package:app_v2/model/favoritelist.dart';

class FavoriteAPI {
  //通过id获取favoritelist
  static Future<FavoriteList> getFavoriteListByID(int id) async {
    final response = await dio.get(
      '/favoritelist/get',
      queryParameters: {
        'id': id
      },
    );
    return FavoriteList.fromJson(response.data);
  }

  //给某个Favorite List添加Video
  static Future<FavoriteList> addVideoToFavoriteList(int fid,int vid) async {
    //给/favorite发送put请求，传递fid和vid
    final response = await dio.put(
      '/favorite',
      data: {
        'fid': fid,
        'vid': vid
      },
    );
    return FavoriteList.fromJson(response.data);
  }

  //删除某个favorite list
  static Future<void> deleteFavoriteList(int id) async {
    await dio.delete(
      '/favorite',
      data: {
        'id': id
      },
    );
    //在这里使用Future Void是让这个可以被await
    return;
  }

  //添加一个新的收藏夹
  static Future<FavoriteList> addFavoriteList(String name) async {
    final response = await dio.put(
      '/favoritelist',
      data: {
        'name': name
      },
    );
    //返回一个FavoriteList
    return FavoriteList.fromJson(response.data);
  }

  //获取用户的所有收藏夹
  static Future<List<FavoriteList>> getFavoriteLists() async {
    final response = await dio.get(
      '/favoritelist/get/all/data'
    );
    //从返回的json的data key解析，data为一组FavoriteList
    return (response.data['data'] as List).map((i) => FavoriteList.fromJson(i)).toList();
  }

  //获取用户所有的收藏夹，但是只有name和id
  static Future<List<Map<String,dynamic>>> getFavoriteListsName() async {
    final response = await dio.get(
      '/favoritelist/get/all'
    );
    return response.data['data'];
  }
}