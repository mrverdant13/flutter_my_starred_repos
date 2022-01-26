// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      username: json['login'] as String,
      avatarUrl: json['avatarUrl'] as String,
      name: json['name'] as String?,
      status: json['status'] == null
          ? null
          : UserStatus.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'login': instance.username,
      'avatarUrl': instance.avatarUrl,
      'name': instance.name,
      'status': instance.status?.toJson(),
    };
