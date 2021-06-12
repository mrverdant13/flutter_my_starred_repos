import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../core/flavors.dart';
import 'routers/app_router.gr.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ListenableProvider<AppRouter>(
            create: (context) => AppRouter(),
          ),
        ],
        builder: (context, _) => MaterialApp.router(
          title: 'App (${kAppFlavor.tag})',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerDelegate: context.read<AppRouter>().delegate(),
          routeInformationParser:
              context.read<AppRouter>().defaultRouteParser(),
        ),
      );
}
