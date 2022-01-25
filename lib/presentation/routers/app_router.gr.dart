// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../features/auth/presentation/screens/auth/screen.dart' as _i3;
import '../../features/auth/presentation/screens/login/screen.dart' as _i2;
import '../../features/counter/presentation/screens/counter/screen.dart' as _i1;
import '../../features/stared_repos/presentation/screens/starred_repos/screen.dart'
    as _i5;
import '../../features/users_placeholder/presentation/screens/users/screen.dart'
    as _i4;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    CounterScreenRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i1.CounterScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginScreenRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.LoginScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    AuthScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AuthScreenRouteArgs>();
      return _i6.CustomPage<Uri>(
          routeData: routeData,
          child: _i3.AuthScreen(
              authorizationEndpoint: args.authorizationEndpoint,
              redirectBaseEndpoint: args.redirectBaseEndpoint),
          opaque: true,
          barrierDismissible: false);
    },
    UsersScreenRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.UsersScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    StarredReposScreenRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.StarredReposScreen(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(CounterScreenRoute.name, path: '/'),
        _i6.RouteConfig(LoginScreenRoute.name, path: '/login-screen'),
        _i6.RouteConfig(AuthScreenRoute.name, path: '/auth-screen'),
        _i6.RouteConfig(UsersScreenRoute.name, path: '/users-screen'),
        _i6.RouteConfig(StarredReposScreenRoute.name,
            path: '/starred-repos-screen')
      ];
}

/// generated route for
/// [_i1.CounterScreen]
class CounterScreenRoute extends _i6.PageRouteInfo<void> {
  const CounterScreenRoute() : super(CounterScreenRoute.name, path: '/');

  static const String name = 'CounterScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i6.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(LoginScreenRoute.name, path: '/login-screen');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.AuthScreen]
class AuthScreenRoute extends _i6.PageRouteInfo<AuthScreenRouteArgs> {
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
/// [_i4.UsersScreen]
class UsersScreenRoute extends _i6.PageRouteInfo<void> {
  const UsersScreenRoute()
      : super(UsersScreenRoute.name, path: '/users-screen');

  static const String name = 'UsersScreenRoute';
}

/// generated route for
/// [_i5.StarredReposScreen]
class StarredReposScreenRoute extends _i6.PageRouteInfo<void> {
  const StarredReposScreenRoute()
      : super(StarredReposScreenRoute.name, path: '/starred-repos-screen');

  static const String name = 'StarredReposScreenRoute';
}
