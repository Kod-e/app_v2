// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoritelist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteList _$FavoriteListFromJson(Map<String, dynamic> json) => FavoriteList(
      id: json['id'] as int,
      name: json['name'] as String?,
      username: json['username'] as String?,
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteListToJson(FavoriteList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'videos': instance.videos,
    };
