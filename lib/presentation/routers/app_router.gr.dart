// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../features/auth/presentation/screens/auth/screen.dart' as _i3;
import '../../features/auth/presentation/screens/login/screen.dart' as _i1;
import '../../features/profile/presentation/profile_screen.dart' as _i2;
import '../../features/stared_repos/presentation/screens/starred_repos/screen.dart'
    as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LoginScreenRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i1.LoginScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    ProfileScreenRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.ProfileScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    AuthScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AuthScreenRouteArgs>();
      return _i5.CustomPage<Uri>(
          routeData: routeData,
          child: _i3.AuthScreen(
              authorizationEndpoint: args.authorizationEndpoint,
              redirectBaseEndpoint: args.redirectBaseEndpoint),
          opaque: true,
          barrierDismissible: false);
    },
    StarredReposScreenRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.StarredReposScreen(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(LoginScreenRoute.name, path: '/'),
        _i5.RouteConfig(ProfileScreenRoute.name, path: '/profile-screen'),
        _i5.RouteConfig(AuthScreenRoute.name, path: '/auth-screen'),
        _i5.RouteConfig(StarredReposScreenRoute.name,
            path: '/starred-repos-screen')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreenRoute extends _i5.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i2.ProfileScreen]
class ProfileScreenRoute extends _i5.PageRouteInfo<void> {
  const ProfileScreenRoute()
      : super(ProfileScreenRoute.name, path: '/profile-screen');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i3.AuthScreen]
class AuthScreenRoute extends _i5.PageRouteInfo<AuthScreenRouteArgs> {
  AuthScreenRoute(
      {required Uri authorizationEndpoint, required Uri redirectBaseEndpoint})
      : super(AuthScreenRoute.name,
            path: '/auth-screen',
            args: AuthScreenRouteArgs(
                authorizationEndpoint: authorizationEndpoint,
                redirectBaseEndpoint: redirectBaseEndpoint));

  static const String name = 'AuthScreenRoute';
}

class AuthScreenRouteArgs {
  const AuthScreenRouteArgs(
      {required this.authorizationEndpoint,
      required this.redirectBaseEndpoint});

  final Uri authorizationEndpoint;

  final Uri redirectBaseEndpoint;

  @override
  String toString() {
    return 'AuthScreenRouteArgs{authorizationEndpoint: $authorizationEndpoint, redirectBaseEndpoint: $redirectBaseEndpoint}';
  }
}

/// generated route for
/// [_i4.StarredReposScreen]
class StarredReposScreenRoute extends _i5.PageRouteInfo<void> {
  const StarredReposScreenRoute()
      : super(StarredReposScreenRoute.name, path: '/starred-repos-screen');

  static const String name = 'StarredReposScreenRoute';
}
