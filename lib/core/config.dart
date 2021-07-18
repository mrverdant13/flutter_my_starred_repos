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

/// An object that holds data required for GitHub auth processes.
@freezed
class GithubAuthConfig with _$GithubAuthConfig {
  /// Creates a GitHub auth data holder.
  @visibleForTesting
  @JsonSerializable(
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: true,
  )
  const factory GithubAuthConfig({
    /// GitHub client ID.
    @JsonKey(
      required: true,
      disallowNullValue: true,
    )
        required String clientId,

    /// GitHub client secret.
    @JsonKey(
      required: true,
      disallowNullValue: true,
    )
        required String clientSecret,
  }) = _GithubAuthConfig;

  /// Creates a GitHub auth data holder from the [json] JSON object.
  factory GithubAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$GithubAuthConfigFromJson(json);
}
