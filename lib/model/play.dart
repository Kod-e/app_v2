// play.dart
import 'package:json_annotation/json_annotation.dart';

part 'play.g.dart';

@JsonSerializable()
class Play {
  final String? h264;
  final String? hevc;
  final String? dash_h264;
  final String? dash_hevc;

  Play({this.h264, this.hevc, this.dash_h264, this.dash_hevc});

  factory Play.fromJson(Map<String, dynamic> json) => _$PlayFromJson(json);
  factory Play.crash() {
    return Play(
    );
  }
  Map<String, dynamic> toJson() => _$PlayToJson(this);
}