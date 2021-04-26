import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import '../presentation/app.dart';

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  runZonedGuarded(
    () => runApp(
      const MyApp(),
    ),
    (error, stackTrace) => log(
      error.toString(),
      stackTrace: stackTrace,
    ),
  );
}
