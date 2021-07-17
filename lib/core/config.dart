import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

/// An object that holds sensitive data required for the app to work.
@freezed
class AppConfig with _$AppConfig {
  /// Creates an app sesitive data holder.
  @visibleForTesting
  const factory AppConfig({
    /// Holder of GitHub auth data.
    required GithubAuthConfig githubAuthConfig,
  }) = _AppConfig;

  /// Creates an app sesitive data holder from the [json] JSON object.
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}

/// An object that holds data required for GitHub auth processes.
@freezed
class GithubAuthConfig with _$GithubAuthConfig {
  /// Creates a GitHub auth data holder.
  @visibleForTesting
  const factory GithubAuthConfig({
    /// GitHub client ID.
    required String clientId,

    /// GitHub client secret.
    required String clientSecret,
  }) = _GithubAuthConfig;

  /// Creates a GitHub auth data holder from the [json] JSON object.
  factory GithubAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$GithubAuthConfigFromJson(json);
}
