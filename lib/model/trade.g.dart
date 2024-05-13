// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) => Trade(
      url: json['url'] as String?,
      from: json['from'] as String?,
      method: json['method'] as String?,
      day: json['day'] as int?,
    );

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'url': instance.url,
      'from': instance.from,
      'method': instance.method,
      'day': instance.day,
    };
