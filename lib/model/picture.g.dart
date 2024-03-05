// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Picture _$PictureFromJson(Map<String, dynamic> json) => Picture(
      jpg: json['jpg'] as String,
      webp: json['webp'] as String,
      avif: json['avif'] as String,
    );

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'jpg': instance.jpg,
      'webp': instance.webp,
      'avif': instance.avif,
    };
