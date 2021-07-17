// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppConfig _$_$_AppConfigFromJson(Map<String, dynamic> json) {
  return _$_AppConfig(
    githubAuthConfig: GithubAuthConfig.fromJson(
        json['githubAuthConfig'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_AppConfigToJson(_$_AppConfig instance) =>
    <String, dynamic>{
      'githubAuthConfig': instance.githubAuthConfig,
    };

_$_GithubAuthConfig _$_$_GithubAuthConfigFromJson(Map<String, dynamic> json) {
  return _$_GithubAuthConfig(
    clientId: json['clientId'] as String,
    clientSecret: json['clientSecret'] as String,
  );
}

Map<String, dynamic> _$_$_GithubAuthConfigToJson(
        _$_GithubAuthConfig instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };
