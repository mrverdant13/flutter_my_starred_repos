import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../presentation/routers/app_router.gr.dart';
import '../../../application/authenticator_cubit/authenticator_cubit.dart';
import '../../../domain/log_in_method.dart';

part 'dimensions.dart';

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
                          Expanded(
                            child: Text(
                              failure.when(
                                canceled: () => 'Login canceled',
                                missingPermissions: () =>
                                    'Some permissions were not granted',
                                offline: () => 'No Internet connection',
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () async => context.logInWithOAuth(),
                          child: const Text('LOG IN'),
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
  Future<void> logInWithOAuth() => read<AuthenticatorCubit>().logIn(
        method: LogInMethod.oAuth(
          callback: _oauthCallback,
        ),
      );

  OAuthCallback get _oauthCallback => ({
        required Uri authorizationEndpoint,
        required Uri redirectBaseEndpoint,
      }) =>
          read<AppRouter>().push<Uri>(
            AuthScreenRoute(
              authorizationEndpoint: authorizationEndpoint,
              redirectBaseEndpoint: redirectBaseEndpoint,
            ),
          );
}
