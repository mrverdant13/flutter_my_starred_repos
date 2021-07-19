import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../core/dependency_injection.dart';
import '../core/flavors.dart';
import '../features/auth/application/authenticator_cubit/authenticator_cubit.dart';
import 'routers/app_router.gr.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ListenableProvider<AppRouter>(
            create: (context) => AppRouter(),
          ),
          BlocProvider(
            create: (context) => getIt<AuthenticatorCubit>()..checkAuthStatus(),
          ),
        ],
        builder: (context, _) =>
            BlocListener<AuthenticatorCubit, AuthenticatorState>(
          listener: (context, authenticatorState) {
            authenticatorState.maybeWhen(
              authenticated: () => context.read<AppRouter>().pushAndPopUntil(
                    const CounterScreenRoute(),
                    predicate: (route) => false,
                  ),
              unauthenticated: () => context.read<AppRouter>().pushAndPopUntil(
                    const LoginScreenRoute(),
                    predicate: (route) => false,
                  ),
              orElse: () {},
            );
          },
          child: MaterialApp.router(
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
        ),
      );
}
