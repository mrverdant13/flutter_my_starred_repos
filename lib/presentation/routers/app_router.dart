import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../screens/counter/screen.dart';
import '../screens/users/screen.dart';

@CustomAutoRouter(
  routes: [
    CustomRoute(
      page: CounterScreen,
      initial: true,
    ),
    CustomRoute(
      page: UsersScreen,
    ),
  ],
)
class $AppRouter {}
