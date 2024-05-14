import 'package:app_v2/api/config.dart';
import 'dart:convert';

class VersionAPI{

  static Future<Map<String, String>> getVersionAndroid() async {
    final response = await dio.get('/version/flutter/android');
    if (response.statusCode == 200) {
      return Map<String, String>.from(response.data);
    } else {
      throw Exception('Failed to get version');
    }
  }
  //windows
  static Future<Map<String, String>> getVersionWindows() async {
    final response = await dio.get('/version/flutter/windows');
    if (response.statusCode == 200) {
      return Map<String, String>.from(response.data);
    } else {
      throw Exception('Failed to get version');
    }
  }
  //macos
  static Future<Map<String, String>> getVersionMacos() async {
    final response = await dio.get('/version/flutter/macos');
    if (response.statusCode == 200) {
      return Map<String, String>.from(response.data);
    } else {
      throw Exception('Failed to get version');
    }
  }
}