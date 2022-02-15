import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_my_starred_repos/features/auth/presentation/screens/auth/screen.dart';
import 'package:flutter_my_starred_repos/features/auth/presentation/screens/login/screen.dart';
import 'package:flutter_my_starred_repos/features/profile/presentation/profile_screen.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/presentation/screens/starred_repos/screen.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@CustomAutoRouter(
  routes: [
    CustomRoute(
      page: LoginScreen,
      initial: true,
    ),
    CustomRoute(
      page: ProfileScreen,
    ),
    CustomRoute<Uri>(
      page: AuthScreen,
    ),
    CustomRoute(
      page: StarredReposScreen,
    ),
  ],
)
class $AppRouter {}

final appRouterPod = ChangeNotifierProvider<AppRouter>(
  (_) => AppRouter(),
);
