import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_auth_config.freezed.dart';
part 'github_auth_config.g.dart';

@freezed
class GithubAuthConfig with _$GithubAuthConfig {
  @visibleForTesting
  // ignore: invalid_annotation_target
  @JsonSerializable(
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: true,
  )
  const factory GithubAuthConfig({
    // ignore: invalid_annotation_target
    @JsonKey(
      required: true,
      disallowNullValue: true,
    )
        required String clientId,

    // ignore: invalid_annotation_target
    @JsonKey(
      required: true,
      disallowNullValue: true,
    )
        required String clientSecret,
  }) = _GithubAuthConfig;

  factory GithubAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$GithubAuthConfigFromJson(json);
}
