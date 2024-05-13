import 'package:json_annotation/json_annotation.dart';
import 'package:app_v2/model/video.dart';

part 'favoritelist.g.dart';

@JsonSerializable()
class FavoriteList {
  int id;
  final String? name;
  final String? username;

  @JsonKey(name: 'videos')
  final List<Video>? videos;

  FavoriteList({
    required this.id, 
    this.name, 
    this.username, 
    this.videos
  });

  factory FavoriteList.loading() {
    return FavoriteList(
      id: 0, 
      name: '加载中...', 
      username: '加载中...',
      videos: []
    );
  }

  factory FavoriteList.fromJson(Map<String, dynamic> json) => _$FavoriteListFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteListToJson(this);
}