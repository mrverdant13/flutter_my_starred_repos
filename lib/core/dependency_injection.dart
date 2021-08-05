import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/core/dependency_injection.dart' as auth;
import '../features/stared_repos/core/dependency_injection.dart'
    as starred_repos;
import '../features/users_placeholder/core/dependency_injection.dart'
    as users_placeholder;
import 'config.dart';
import 'flavors.dart';

final flavorPod = Provider<Flavor>(
  (_) => throw StateError(
    'The app flavor has not been initialized',
  ),
);

final appConfigPod = Provider<AppConfig>(
  (_) => throw StateError(
    'The app config has not been initialized',
  ),
);

Future<List<Override>> getInjectionOverrides({
  required Flavor flavor,
  required AppConfig appConfig,
}) async =>
    [
      flavorPod.overrideWithValue(flavor),
      appConfigPod.overrideWithValue(appConfig),
      ...await auth.overrides(),
      ...await starred_repos.overrides(),
      ...await users_placeholder.overrides(),
    ];
