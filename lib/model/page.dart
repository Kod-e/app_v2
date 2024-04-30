import 'package:json_annotation/json_annotation.dart';
import 'viewlist.dart';

part 'page.g.dart';

@JsonSerializable()
class Page {
  final int? id;
  final String? name;
  final List<ViewList>? viewlists;

  Page({
    this.id,
    this.name,
    this.viewlists,
  });

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);
}