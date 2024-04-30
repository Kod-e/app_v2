import 'package:app_v2/model/video.dart';
import 'package:app_v2/model/tag.dart';
import 'package:app_v2/api/tag.dart';
import 'package:flutter/material.dart';

class TagPageService with ChangeNotifier {
  // ignore: non_constant_identifier_names
  int page_count = 30;

  late Tag tag;
  //目前的页数
  late int videoPageOffset;
  late int tagPageOffset;

  late int tagPageCount;
  late int videoPageCount;
  Map<int, List<Video>> videosByPage = {};
  Map<int, List<Tag>> tagsByPage = {};

  List<Video> videoNowPage = [];
  List<Tag> tagNowPage = [];
  //构造函数
  TagPageService(Tag tag) {
    this.tagPageOffset = 0;
    this.videoPageOffset = 0;
    this.videoPageCount = 0;
    this.tagPageCount = 0;
    this.tag = tag;
  }

  //获取第一页
  // ignore: non_constant_identifier_names
  Future<void> GetFirstPage() async {
    // 同时执行三个异步操作
    var results = await Future.wait([
      TagAPI.getTagVideos(tag.id, page: 0, pageCount: page_count),
      TagAPI.getTagTags(tag.id, page: 0, pageCount: page_count),
      TagAPI.getTagCount(tag.id)
    ]);

    // 从结果中获取数据，并进行类型转换
    videosByPage[0] = results[0] as List<Video>;
    tagsByPage[0] = results[1] as List<Tag>;
    Map<String, dynamic> countData = results[2] as Map<String, dynamic>;
    tagNowPage = tagsByPage[0]!;
    videoNowPage = videosByPage[0]!;
    // 计算页数
    videoPageCount = (countData['video_num']! / page_count).ceil();
    tagPageCount = (countData['tag_num']! / page_count).ceil();
    notifyListeners();
  }
  //获取指定的video页面
  Future<void> ToVideoPage(int page) async {
    //如果缓存中不存在就获取
    if (videosByPage[page] == null) {
      var videos = await TagAPI.getTagVideos(tag.id, page: page, pageCount: page_count);
      videosByPage[page] = videos;
    }
    if (videosByPage[page] != null){
      videoNowPage = videosByPage[page]!;
    }
    //设置offset
    videoPageOffset = page;
    notifyListeners();
  }
  //获取指定的tag页面
  Future<void> ToTagPage(int page) async {
    //如果缓存中不存在就获取
    if (tagsByPage[page] == null) {
      var tags = await TagAPI.getTagTags(tag.id, page: page, pageCount: page_count);
      tagsByPage[page] = tags;
    }
    if (tagsByPage[page] != null){
      tagNowPage = tagsByPage[page]!;
    }
    //设置offset
    tagPageOffset = page;
    notifyListeners();
  }
}
