// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_auth_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubAuthConfig _$$_GithubAuthConfigFromJson(Map json) => $checkedCreate(
      r'_$_GithubAuthConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['clientId', 'clientSecret'],
          requiredKeys: const ['clientId', 'clientSecret'],
          disallowNullValues: const ['clientId', 'clientSecret'],
        );
        final val = _$_GithubAuthConfig(
          clientId: $checkedConvert('clientId', (v) => v as String),
          clientSecret: $checkedConvert('clientSecret', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_GithubAuthConfigToJson(_$_GithubAuthConfig instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };
