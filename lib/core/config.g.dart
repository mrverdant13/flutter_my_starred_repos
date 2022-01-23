// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppConfig _$$_AppConfigFromJson(Map json) => $checkedCreate(
      r'_$_AppConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['githubAuthConfig'],
          requiredKeys: const ['githubAuthConfig'],
          disallowNullValues: const ['githubAuthConfig'],
        );
        final val = _$_AppConfig(
          githubAuthConfig: $checkedConvert(
              'githubAuthConfig',
              (v) => GithubAuthConfig.fromJson(
                  Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_AppConfigToJson(_$_AppConfig instance) =>
    <String, dynamic>{
      'githubAuthConfig': instance.githubAuthConfig.toJson(),
    };
