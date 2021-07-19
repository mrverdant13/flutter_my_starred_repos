import 'dart:async';

import 'package:emoji_lumberdash/emoji_lumberdash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lumberdash/lumberdash.dart' as logger;

import '../features/auth/core/dependency_injection.dart' as auth;
import '../features/stared_repos/core/dependency_injection.dart'
    as starred_repos;
import '../features/users_placeholder/core/dependency_injection.dart'
    as users_placeholder;
import '../presentation/app.dart';
import 'config.dart';
import 'dependency_injection.dart';
import 'flavors.dart';

Future<void> startApp(Flavor flavor) async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      logger.putLumberdashToWork(
        withClients: [
          if (kDebugMode)
            EmojiLumberdash(
              errorMethodCount: 10,
              lineLength: 80,
            ),
        ],
      );

      final configYamlString = await rootBundle.loadString(
        'assets/config/app_config.${flavor.tag.toLowerCase()}.yaml',
      );

      final appConfig = AppConfig.fromYamlString(configYamlString);

      await injectDependencies(
        flavor: flavor,
        config: appConfig,
      );
      await users_placeholder.injectDependencies(
        flavor: flavor,
      );
      await auth.injectDependencies();
      await starred_repos.injectDependencies();

      FlutterError.onError = (details) {
        logger.logError(
          details.exception,
          stacktrace: details.stack,
        );
      };

      runApp(
        flavor == Flavor.prod
            ? const MyApp()
            : Directionality(
                textDirection: TextDirection.ltr,
                child: Banner(
                  message: flavor.tag,
                  location: BannerLocation.topStart,
                  child: const MyApp(),
                ),
              ),
      );
    },
    (error, stackTrace) => logger.logError(
      error,
      stacktrace: stackTrace,
    ),
  );
}
