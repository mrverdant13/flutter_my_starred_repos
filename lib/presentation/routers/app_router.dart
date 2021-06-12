import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../screens/counter/screen.dart';

@CustomAutoRouter(
  routes: [
    CustomRoute(
      page: CounterScreen,
      initial: true,
    ),
  ],
)
class $AppRouter {}
