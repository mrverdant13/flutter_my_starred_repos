import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../presentation/routers/app_router.gr.dart';
import '../../../application/authenticator_cubit/authenticator_cubit.dart';
import '../../../domain/log_in_method.dart';

part 'dimensions.dart';
part 'l10n.dart';

/// {@template LoginScreen}
/// A screen that displays the available login options.
/// {@endtemplate}
class LoginScreen extends StatelessWidget {
  /// Creates a new login screen.
  ///
  /// {@macro LoginScreen}
  const LoginScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Builder(
          builder: (context) =>
              BlocListener<AuthenticatorCubit, AuthenticatorState>(
            listener: (context, authenticatorState) {
              authenticatorState.maybeWhen(
                failure: (failure) => failure.when(
                  logIn: (failure) =>
                      ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Row(
                        children: [
                          const Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: Text(
                              failure.when(
                                canceled: () => context.loginCanceledMessage,
                                missingPermissions: () =>
                                    context.missingLoginPermissionsMessage,
                                offline: () => context.loginOfflineMessage,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                orElse: () {},
              );
            },
            child: SafeArea(
              child: SingleChildScrollView(
                padding: _screenContentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LimitedBox(
                      maxHeight: _iconMaxHeight,
                      child: FittedBox(
                        child: Center(
                          child: Icon(
                            MdiIcons.github,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: _separationIconButton),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: _buttonMinWidth,
                        ),
                        child: Consumer(
                          builder: (context, ref, _) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () async => context.logInWithOAuth(
                              appRouter: ref.watch(appRouterPod),
                            ),
                            child: Text(context.loginButtonLabel),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

/// A [BuildContext] that provides login utilities.
extension _OAuthContext on BuildContext {
  Future<void> logInWithOAuth({
    required AppRouter appRouter,
  }) =>
      read<AuthenticatorCubit>().logIn(
        method: LogInMethod.oAuth(
          callback: _oauthCallback(
            appRouter: appRouter,
          ),
        ),
      );

  OAuthCallback _oauthCallback({
    required AppRouter appRouter,
  }) =>
      ({
        required Uri authorizationEndpoint,
        required Uri redirectBaseEndpoint,
      }) =>
          appRouter.push<Uri>(
            AuthScreenRoute(
              authorizationEndpoint: authorizationEndpoint,
              redirectBaseEndpoint: redirectBaseEndpoint,
            ),
          );
}
