import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/dependency_injection.dart';
import '../core/flavors.dart';
import 'routers/app_router.gr.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(authCubitPod).checkAuthStatus();
    }, []);
    return Consumer(
      builder: (context, ref, _) => BlocListener<AuthCubit, AuthState>(
        bloc: ref.watch(authCubitPod),
        listener: (context, authenticatorState) {
          final appRouter = ref.read(appRouterPod);
          authenticatorState.maybeWhen(
            loaded: (isLoggedIn) => appRouter.pushAndPopUntil(
              isLoggedIn
                  ? const ProfileScreenRoute()
                  : const LoginScreenRoute(),
              predicate: (route) => false,
            ),
            orElse: () {},
          );
        },
        child: MaterialApp.router(
          title: 'App (${ref.watch(flavorPod).tag})',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerDelegate: ref.watch(appRouterPod).delegate(),
          routeInformationParser: ref.watch(appRouterPod).defaultRouteParser(),
        ),
      ),
    );
  }
}
