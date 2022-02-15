import 'dart:async';

import 'package:emoji_lumberdash/emoji_lumberdash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart'
    as core;
import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart'
    as starred_repos;
import 'package:flutter_my_starred_repos/presentation/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lumberdash/lumberdash.dart' as logger;

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

      FlutterError.onError = (details) {
        logger.logError(
          details.exception,
          stacktrace: details.stack,
        );
      };

      final configYamlString = await rootBundle.loadString(
        'assets/config/app_config.${flavor.tag.toLowerCase()}.yaml',
      );
      final appConfig = AppConfig.fromYamlString(configYamlString);

      final injectionOverrides = [
        ...await core.getInjectionOverrides(
          flavor: flavor,
          appConfig: appConfig,
        ),
        ...await starred_repos.getInjectionOverrides(),
      ];

      runApp(
        ProviderScope(
          overrides: injectionOverrides,
          child: flavor == Flavor.prod
              ? const MyApp()
              : Directionality(
                  textDirection: TextDirection.ltr,
                  child: Banner(
                    message: flavor.tag,
                    location: BannerLocation.topStart,
                    child: const MyApp(),
                  ),
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
