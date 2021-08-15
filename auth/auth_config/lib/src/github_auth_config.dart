import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_auth_config.freezed.dart';
part 'github_auth_config.g.dart';

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
