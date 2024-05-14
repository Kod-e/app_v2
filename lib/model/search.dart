import 'package:json_annotation/json_annotation.dart';
import 'package:app_v2/model/video.dart';
import 'package:app_v2/model/tag.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  Video? subtitle;
  List<Video>? videos;
  List<Tag>? tags;

  Search({this.subtitle, this.videos, this.tags});

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
  //loading
  static Search loading() {
    return Search(
      subtitle: null,
      videos: [],
      tags: [],
    );
  }
}