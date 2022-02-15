import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'widgets/auth_webview.dart';

/// {@template AuthScreen}
/// A screen that wraps a webview used for the auth process.
/// {@endtemplate}
class AuthScreen extends StatelessWidget {
  /// Creates an auth screen.
  ///
  /// {@macro AuthScreen}
  ///
  /// The [authorizationEndpoint] is visited and an endpoint wiht the sabe base
  /// URL as the [redirectBaseEndpoint] is returned.
  const AuthScreen({
    required this.authorizationEndpoint,
    required this.redirectBaseEndpoint,
  });

  /// The authorization endpoint to be visited to auth the app.
  final Uri authorizationEndpoint;

  /// The endpoint that holds the base URL for the final redirect endpoint that
  /// includes auth data.
  final Uri redirectBaseEndpoint;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: _AuthWebview(
            authorizationEndpoint: authorizationEndpoint,
            redirectBaseEndpoint: redirectBaseEndpoint,
          ),
        ),
      );
}
