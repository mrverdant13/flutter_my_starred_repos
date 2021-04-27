import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import '../presentation/app.dart';
import 'dependency_injection.dart';
import 'flavors.dart';

Future<void> startApp(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton(flavor);

  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  runZonedGuarded(
    () => runApp(
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
    ),
    (error, stackTrace) => log(
      error.toString(),
      stackTrace: stackTrace,
    ),
  );
}
