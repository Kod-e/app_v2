// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      id: json['id'] as String,
      name: json['name'] as String,
      picture: Picture.fromJson(json['picture'] as Map<String, dynamic>),
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'subtitle': instance.subtitle,
      'description': instance.description,
    };