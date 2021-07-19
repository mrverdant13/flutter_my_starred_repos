import 'package:get_it/get_it.dart';

import 'config.dart';
import 'flavors.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies({
  required Flavor flavor,
  required AppConfig config,
}) async {
  getIt.registerSingleton(flavor);

  getIt.registerLazySingleton<AppConfig>(
    () => config,
  );
}
