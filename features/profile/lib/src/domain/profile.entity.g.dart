// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      username: json['login'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'login': instance.username,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };
