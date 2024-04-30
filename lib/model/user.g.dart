// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      passwordMd5: json['password_md5'] as String?,
      premission: json['premission'] as int?,
      premissionEndTime: json['premission_end_time'] as String?,
      createTime: json['create_time'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password_md5': instance.passwordMd5,
      'premission': instance.premission,
      'premission_end_time': instance.premissionEndTime,
      'create_time': instance.createTime,
      'token': instance.token,
    };
