// video.dart
import 'package:app_v2/model/tag.dart';
import 'package:json_annotation/json_annotation.dart';
import 'picture.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  final int id;
  final String? name;
  final Picture? picture;
  final String? subtitle;
  final String? description;
  final List<Tag>? tags;

  Video({
    required this.id, 
    this.name, 
    this.picture, 
    this.subtitle, 
    this.description,
    this.tags
  });
  
  factory Video.loading() {
    return Video(
      id: 0, 
      name: '加载中...', 
      picture: Picture(
        jpg: 'https://www.loliapi.com/acg/',
        webp: 'https://www.loliapi.com/acg/',
        avif: 'https://www.loliapi.com/acg/',
      ), 
      subtitle: '加载中...', 
      description: '加载中...',
      tags: []
    );
  }

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}