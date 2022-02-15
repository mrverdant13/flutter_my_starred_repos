import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpScreen on WidgetTester {
  Future<void> pumpScreen({
    required Widget screenWidget,
  }) =>
      pumpWidget(
        MaterialApp(
          home: screenWidget,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );
}
