// video.dart
import 'dart:ffi';

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

  Video({
    required this.id, 
    this.name, 
    this.picture, 
    this.subtitle, 
    this.description
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}