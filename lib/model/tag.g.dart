// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as String,
      name: json['name'] as String,
      picture: Picture.fromJson(json['picture'] as Map<String, dynamic>),
      description: json['description'] as String,
      parentId: json['parent_id'] as String,
      isMain: json['is_main'] as bool,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'description': instance.description,
      'parent_id': instance.parentId,
      'is_main': instance.isMain,
    };
