import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'flavors.dart';

part 'config.freezed.dart';
part 'config.g.dart';

/// An object that holds sensitive data required for the app to work.
@freezed
class AppConfig with _$AppConfig {
  /// Creates an app sesitive data holder.
  const factory AppConfig({
    /// Holder of GitHub auth data.
    required GithubAuthConfig githubAuthConfig,
  }) = _AppConfig;

  /// Creates an app sesitive data holder from the [json] JSON object.
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  /// Creates an app sesitive data holder from the bundled JSON object according
  /// to the specified [flavor].
  static Future<AppConfig> create({
    required Flavor flavor,
  }) async {
    final configString = await rootBundle.loadString(
      'assets/config/app_config.${flavor.tag.toLowerCase()}.json',
    );

    final config = json.decode(configString) as Map<String, dynamic>;

    return AppConfig.fromJson(
      config,
    );
  }
}

/// An object that holds data required for GitHub auth processes.
@freezed
class GithubAuthConfig with _$GithubAuthConfig {
  /// Creates a GitHub auth data holder.
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
