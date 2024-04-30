import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? name;
  final String? email;
  @JsonKey(name: 'password_md5')
  final String? passwordMd5;
  final int? premission;
  @JsonKey(name: 'premission_end_time')
  final String? premissionEndTime;
  @JsonKey(name: 'create_time')
  final String? createTime;
  final String? token;

  factory User.loading() {
  return User(
    id: 0, 
    name: '加载中...', 
    email: '加载中...', 
    passwordMd5: '加载中...', 
    premission: 0, 
    premissionEndTime: '加载中...', 
    createTime: '加载中...', 
    token: '加载中...'
  );
}

  User({this.id, this.name, this.email, this.passwordMd5, this.premission, this.premissionEndTime, this.createTime, this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}