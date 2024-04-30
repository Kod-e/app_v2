// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Play _$PlayFromJson(Map<String, dynamic> json) => Play(
      h264: json['h264'] as String?,
      hevc: json['hevc'] as String?,
      dash_h264: json['dash_h264'] as String?,
      dash_hevc: json['dash_hevc'] as String?,
    );

Map<String, dynamic> _$PlayToJson(Play instance) => <String, dynamic>{
      'h264': instance.h264,
      'hevc': instance.hevc,
      'dash_h264': instance.dash_h264,
      'dash_hevc': instance.dash_hevc,
    };
