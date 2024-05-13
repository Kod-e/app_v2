import 'package:json_annotation/json_annotation.dart';

part 'trade.g.dart';

@JsonSerializable()
class Trade {
  final String? url;
  final String? from;
  final String? method;
  final int? day;

  Trade({
    this.url,
    this.from,
    this.method,
    this.day,
  });

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);

  Map<String, dynamic> toJson() => _$TradeToJson(this);
}