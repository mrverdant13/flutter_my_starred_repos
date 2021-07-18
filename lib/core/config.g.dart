// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppConfig _$_$_AppConfigFromJson(Map json) {
  return $checkedNew(r'_$_AppConfig', json, () {
    $checkKeys(json,
        allowedKeys: const ['githubAuthConfig'],
        requiredKeys: const ['githubAuthConfig'],
        disallowNullValues: const ['githubAuthConfig']);
    final val = _$_AppConfig(
      githubAuthConfig: $checkedConvert(
          json,
          'githubAuthConfig',
          (v) =>
              GithubAuthConfig.fromJson(Map<String, dynamic>.from(v as Map))),
    );
    return val;
  });
}

Map<String, dynamic> _$_$_AppConfigToJson(_$_AppConfig instance) =>
    <String, dynamic>{
      'githubAuthConfig': instance.githubAuthConfig,
    };

_$_GithubAuthConfig _$_$_GithubAuthConfigFromJson(Map json) {
  return $checkedNew(r'_$_GithubAuthConfig', json, () {
    $checkKeys(json,
        allowedKeys: const ['clientId', 'clientSecret'],
        requiredKeys: const ['clientId', 'clientSecret'],
        disallowNullValues: const ['clientId', 'clientSecret']);
    final val = _$_GithubAuthConfig(
      clientId: $checkedConvert(json, 'clientId', (v) => v as String),
      clientSecret: $checkedConvert(json, 'clientSecret', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$_$_GithubAuthConfigToJson(
        _$_GithubAuthConfig instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };
