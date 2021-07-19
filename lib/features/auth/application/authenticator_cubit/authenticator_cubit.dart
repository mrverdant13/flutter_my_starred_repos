import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/log_in_failure.dart';
import '../../domain/log_in_method.dart';
import '../../infrastructure/facades/auth_service/interface.dart';

part 'authenticator_cubit.freezed.dart';
part 'authenticator_state.dart';

/// {@template AuthenticatorCubit}
/// A cubit that manages auth actions.
/// {@endtemplate}
class AuthenticatorCubit extends Cubit<AuthenticatorState> {
  /// Creates an [AuthenticatorCubit].
  ///
  /// {@macro AuthenticatorCubit}
  ///
  /// It uses a [authService] to run auth processes.
  AuthenticatorCubit({
    required AuthService authService,
  })  : _authService = authService,
        super(
          const AuthenticatorState.loading(),
        );

  /// The auth service that actually performs auth actions.
  final AuthService _authService;

  /// Starts the current authentication status check.
  Future<void> checkAuthStatus() async {
    emit(const AuthenticatorState.loading());

    final isLoggedIn = await _authService.isLoggedIn();

    emit(
      isLoggedIn
          ? const AuthenticatorState.authenticated()
          : const AuthenticatorState.unauthenticated(),
    );
  }

  /// Starts the login process following the given [method].
  Future<void> logIn({
    required LogInMethod method,
  }) async {
    emit(const AuthenticatorState.loading());

    final failureOrNothing = await _authService.logIn(
      method: method,
    );

    emit(
      failureOrNothing.fold(
        (f) => AuthenticatorState.failure(
          AuthenticatorFailure.logIn(f),
        ),
        (_) => const AuthenticatorState.authenticated(),
      ),
    );
  }

  /// Starts the logout process.
  Future<void> logOut() async {
    emit(const AuthenticatorState.loading());
    await _authService.logOut();
    emit(const AuthenticatorState.unauthenticated());
  }
}
