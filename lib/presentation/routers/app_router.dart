import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_my_starred_repos/features/profile/presentation/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/auth/screen.dart';
import '../../features/auth/presentation/screens/login/screen.dart';
import '../../features/stared_repos/presentation/screens/starred_repos/screen.dart';
import '../../features/users_placeholder/presentation/screens/users/screen.dart';
import 'app_router.gr.dart';

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
      page: UsersScreen,
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
