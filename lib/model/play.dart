// play.dart
import 'package:json_annotation/json_annotation.dart';

part 'play.g.dart';

@JsonSerializable()
class Play {
  final String h264;
  final String hevc;

  Play({required this.h264, required this.hevc});

  factory Play.fromJson(Map<String, dynamic> json) => _$PlayFromJson(json);

  Map<String, dynamic> toJson() => _$PlayToJson(this);
}