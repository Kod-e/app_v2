// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page _$PageFromJson(Map<String, dynamic> json) => Page(
      id: json['id'] as int?,
      name: json['name'] as String?,
      viewlists: (json['viewlists'] as List<dynamic>?)
          ?.map((e) => ViewList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'viewlists': instance.viewlists,
    };
