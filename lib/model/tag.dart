// tag.dart
import 'package:json_annotation/json_annotation.dart';
import 'picture.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  final String id;
  final String name;
  final Picture picture;
  final String description;

  @JsonKey(name: 'parent_id')
  final String parentId;

  @JsonKey(name: 'is_main')
  final bool isMain;

  Tag({required this.id, required this.name, required this.picture, required this.description, required this.parentId, required this.isMain});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}