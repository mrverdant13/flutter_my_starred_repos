import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/l10n/l10n.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'dimensions.dart';
part 'l10n.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        body: Builder(
          builder: (context) => BlocListener<AuthCubit, AuthState>(
            bloc: ref.watch(authCubitPod),
            listener: (context, authState) => authState.whenOrNull(
              failure: (isLoggedIn, failure) => failure.when(
                logIn: (failure) => ScaffoldMessenger.of(context).showSnackBar(
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
                              unexpected: () => context.loginUnexpectedMessage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                            onPressed: ref.watch(authCubitPod).isLoading
                                ? null
                                : () async => ref.logInWithOAuth(),
                            child: Text(
                              ref.watch(authCubitPod).isLoading
                                  ? 'Loading...'
                                  : context.loginButtonLabel,
                            ),
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

/// A [WidgetRef] that provides login utilities.
extension _OAuthRef on WidgetRef {
  Future<void> logInWithOAuth() => read(authCubitPod).logIn(
        method: LoginMethod.oAuth(
          callback: _oauthCallback(),
        ),
      );

  OAuthCallback _oauthCallback() => ({
        required Uri authorizationEndpoint,
        required Uri redirectBaseEndpoint,
      }) =>
          read(appRouterPod).push<Uri>(
            AuthScreenRoute(
              authorizationEndpoint: authorizationEndpoint,
              redirectBaseEndpoint: redirectBaseEndpoint,
            ),
          );
}
