import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    ];
