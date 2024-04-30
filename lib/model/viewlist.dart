import 'package:json_annotation/json_annotation.dart';

part 'viewlist.g.dart';

@JsonSerializable()
class ViewList {
  final int? id;
  final String? name;
  final int? order;
  final int? type;
  final int? pid;
  final int? tid;
  final Map<String, dynamic>? data;

  ViewList({
    this.id,
    this.name,
    this.order,
    this.type,
    this.pid,
    this.tid,
    this.data,
  });

  factory ViewList.fromJson(Map<String, dynamic> json) => _$ViewListFromJson(json);

  Map<String, dynamic> toJson() => _$ViewListToJson(this);
}