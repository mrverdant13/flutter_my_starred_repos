import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'github_auth_config.freezed.dart';
part 'github_auth_config.g.dart';

/// An object that holds data required for GitHub auth processes.
@freezed
class GithubAuthConfig with _$GithubAuthConfig {
  /// Creates a GitHub auth data holder.
  @visibleForTesting
  // ignore: invalid_annotation_target
  @JsonSerializable(
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: true,
  )
  const factory GithubAuthConfig({
    /// GitHub client ID.
    // ignore: invalid_annotation_target
    @JsonKey(
      required: true,
      disallowNullValue: true,
    )
        required String clientId,

    /// GitHub client secret.
    // ignore: invalid_annotation_target
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
