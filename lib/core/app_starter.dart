import 'dart:async';

import 'package:emoji_lumberdash/emoji_lumberdash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart' as logger;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sembast/sembast_io.dart';

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

      final dbDir = await getApplicationDocumentsDirectory();
      await dbDir.create(recursive: true);
      final dbPath = path.join(dbDir.path, 'my_database.db');
      final db = await databaseFactoryIo.openDatabase(dbPath);

      final container = ProviderContainer(
        overrides: [
          flavorPod.overrideWithValue(flavor),
          appConfigPod.overrideWithValue(appConfig),
          sembastDbPod.overrideWithValue(db),
        ],
      );

      FlutterError.onError = (details) {
        logger.logError(
          details.exception,
          stacktrace: details.stack,
        );
      };

      runApp(
        UncontrolledProviderScope(
          container: container,
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
