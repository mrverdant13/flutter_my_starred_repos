import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(
      authNotifierPod,
      (_, authState) => authState.whenOrNull(
        loaded: (isLoggedIn) => ref.read(appRouterPod).pushAndPopUntil(
              isLoggedIn
                  ? const ProfileScreenRoute()
                  : const LoginScreenRoute(),
              predicate: (route) => false,
            ),
      ),
    );
    useEffect(
      () {
        WidgetsBinding.instance?.addPostFrameCallback(
          (_) => ref.read(authNotifierPod.notifier).checkAuthStatus(),
        );
        return;
      },
      [],
    );
    return MaterialApp.router(
      title: 'App (${ref.watch(flavorPod).tag})',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: ref.watch(appRouterPod).delegate(),
      routeInformationParser: ref.watch(appRouterPod).defaultRouteParser(),
    );
  }
}
