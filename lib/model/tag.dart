// tag.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:app_v2/model/video.dart';
import 'picture.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  int id;
  final String? name;
  final Picture? picture;
  final String? description;

  @JsonKey(name: 'parent_id')
  final int? parentId;

  @JsonKey(name: 'is_main')
  final bool? isMain;

  @JsonKey(name: 'tags')
  final List<Tag>? tags;

  @JsonKey(name: 'videos')
  final List<Video>? videos;

  Tag({
    required this.id, 
    this.name, 
    this.picture, 
    this.description, 
    this.parentId, 
    this.isMain,
    this.tags,
    this.videos
  });

  factory Tag.loading() {
    return Tag(
      id: 1, 
      name: '加载中...', 
      picture: Picture(
        jpg: 'https://www.loliapi.com/acg/',
        webp: 'https://www.loliapi.com/acg/',
        avif: 'https://www.loliapi.com/acg/',
      ), 
      description: '加载中...',
      parentId: 0,
      isMain: false,
      tags: [],
      videos: []
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}