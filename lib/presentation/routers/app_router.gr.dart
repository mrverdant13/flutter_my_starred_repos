// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../features/auth/presentation/screens/auth/screen.dart' as _i4;
import '../screens/counter/screen.dart' as _i3;
import '../screens/users/screen.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    CounterScreenRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.CounterScreen();
        },
        opaque: true,
        barrierDismissible: false),
    AuthScreenRoute.name: (routeData) => _i1.CustomPage<Uri>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AuthScreenRouteArgs>();
          return _i4.AuthScreen(
              authorizationEndpoint: args.authorizationEndpoint,
              redirectBaseEndpoint: args.redirectBaseEndpoint);
        },
        opaque: true,
        barrierDismissible: false),
    UsersScreenRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.UsersScreen();
        },
        opaque: true,
        barrierDismissible: false)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(CounterScreenRoute.name, path: '/'),
        _i1.RouteConfig(AuthScreenRoute.name, path: '/auth-screen'),
        _i1.RouteConfig(UsersScreenRoute.name, path: '/users-screen')
      ];
}

class CounterScreenRoute extends _i1.PageRouteInfo {
  const CounterScreenRoute() : super(name, path: '/');

  static const String name = 'CounterScreenRoute';
}

class AuthScreenRoute extends _i1.PageRouteInfo<AuthScreenRouteArgs> {
  AuthScreenRoute(
      {required Uri authorizationEndpoint, required Uri redirectBaseEndpoint})
      : super(name,
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
}

class UsersScreenRoute extends _i1.PageRouteInfo {
  const UsersScreenRoute() : super(name, path: '/users-screen');

  static const String name = 'UsersScreenRoute';
}
