// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/counter/screen.dart' as _i3;
import '../screens/users/screen.dart' as _i4;

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
    UsersScreenRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.UsersScreen();
        },
        opaque: true,
        barrierDismissible: false)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(CounterScreenRoute.name, path: '/'),
        _i1.RouteConfig(UsersScreenRoute.name, path: '/users-screen')
      ];
}

class CounterScreenRoute extends _i1.PageRouteInfo {
  const CounterScreenRoute() : super(name, path: '/');

  static const String name = 'CounterScreenRoute';
}

class UsersScreenRoute extends _i1.PageRouteInfo {
  const UsersScreenRoute() : super(name, path: '/users-screen');

  static const String name = 'UsersScreenRoute';
}
