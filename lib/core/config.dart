import 'package:auth_config/auth_config.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

/// An object that holds sensitive data required for the app to work.
@freezed
class AppConfig with _$AppConfig {
  /// Creates an app sesitive data holder.
  @visibleForTesting
  @JsonSerializable(
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: true,
  )
  const factory AppConfig({
    /// Holder of GitHub auth data.
    @JsonKey(
      required: true,
      disallowNullValue: true,
    )
        required GithubAuthConfig githubAuthConfig,
  }) = _AppConfig;

  /// Creates an app sesitive data holder from the [configYamlString] string
  /// that represents a YAML object.
  factory AppConfig.fromYamlString(String configYamlString) =>
      checkedYamlDecode<AppConfig>(
        configYamlString,
        (configYamlMap) => _$_$_AppConfigFromJson(
          (configYamlMap! as YamlMap).value,
        ),
      );
}
