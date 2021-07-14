import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../../features/auth/presentation/screens/auth/screen.dart';
import '../../features/auth/presentation/screens/login/screen.dart';
import '../screens/counter/screen.dart';
import '../screens/users/screen.dart';

@CustomAutoRouter(
  routes: [
    CustomRoute(
      page: CounterScreen,
      initial: true,
    ),
    CustomRoute(
      page: LoginScreen,
    ),
    CustomRoute<Uri>(
      page: AuthScreen,
    ),
    CustomRoute(
      page: UsersScreen,
    ),
  ],
)
class $AppRouter {}
