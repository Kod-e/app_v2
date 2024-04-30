// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewList _$ViewListFromJson(Map<String, dynamic> json) => ViewList(
      id: json['id'] as int?,
      name: json['name'] as String?,
      order: json['order'] as int?,
      type: json['type'] as int?,
      pid: json['pid'] as int?,
      tid: json['tid'] as int?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ViewListToJson(ViewList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'type': instance.type,
      'pid': instance.pid,
      'tid': instance.tid,
      'data': instance.data,
    };
