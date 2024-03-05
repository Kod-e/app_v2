// video.dart
import 'package:json_annotation/json_annotation.dart';
import 'picture.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  final String id;
  final String name;
  final Picture picture;
  final String subtitle;
  final String description;

  Video({required this.id, required this.name, required this.picture, required this.subtitle, required this.description});

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}