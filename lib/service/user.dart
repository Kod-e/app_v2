import 'package:app_v2/model/user.dart';
import 'package:app_v2/api/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserService {
  //登陆函数，可能会发生异常
  static Future<User> login(String name, String passwordMd5) async {
    //通过user api获得user实例
    //在这里不捕获错误，向上传递以方便UI处理
    User user = await UserAPI.login(name, passwordMd5);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //这里token使用了！，还没处理异常的情况，应该在之前抛出异常
    await prefs.setString('token', user.token!);
    return user;
  }
  //尝试获得User
  static Future<User?> tryGetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      return null;
    }
    return UserAPI.getUser(token);
  }
  //注册函数，可能会发生异常
  static Future<User> register(String name, String passwordMd5) async {
    //通过user api获得user实例
    //在这里不捕获错误，向上传递以方便UI处理
    User user = await UserAPI.registerUser(name, passwordMd5);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //这里token使用了！，还没处理异常的情况，应该在之前抛出异常
    await prefs.setString('token', user.token!);
    return user;
  }
  //退出登陆函数
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}