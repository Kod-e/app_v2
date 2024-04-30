import 'dart:convert';

import 'package:app_v2/api/config.dart';
import 'package:app_v2/model/user.dart';
class UserAPI{
  //通过password_md5和name获得token（登陆）
  //发生错误会直接throw出错误信息，请捕获并显示
  static Future<User> login(String name,String passwordMd5) async {
    final response = await dio.post(
      '/user/login',
      data: {
        'name': name,
        'password_md5': passwordMd5,
        'device' : 'Flutter App'
      },
    );
    if (response.statusCode != 200) {
      throw Exception('发生错误 请联系客服 代码: ${response.statusCode}');
    }
    if (response.data == "password error") {
      throw Exception('密码错误');
    }
    try{
      return User.fromJson(response.data);
    }catch (e){
      throw Exception('未知错误，请联系客服');
    }
  }
  //通过token获得user
  static Future<User?> getUser(String token) async {
    final response = await dio.get(
      '/user/getinfo'
    );
    try{
      return User.fromJson(response.data);
    } catch (e){
      return null;
    }
  }
  //注册新账号
  static Future<User> registerUser(String name,String passwordMd5) async {
    final response = await dio.post(
      '/user/register',
      data: {
        'name': name,
        'password_md5': passwordMd5,
        'device' : 'Flutter App'
      }
    );
    if (response.statusCode != 200) {
      throw Exception('发生错误 请联系客服 代码: ${response.statusCode}');
    }
    if (response.data == "Username already exists") {
      throw Exception('用户名已存在');
    }
    try{
      return User.fromJson(response.data);
    }catch (e){
      throw Exception('未知错误，请联系客服');
    }
  }
}