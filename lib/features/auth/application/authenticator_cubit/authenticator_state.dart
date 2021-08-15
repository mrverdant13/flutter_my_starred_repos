part of 'authenticator_cubit.dart';

/// A union of posible auth failure types.
@freezed
class AuthenticatorFailure with _$AuthenticatorFailure {
  /// A failure that can occur when a user is logging in.
  ///
  /// [failure] is the actual login failure.
  const factory AuthenticatorFailure.logIn(
    /// A login failure.
    LoginFailure failure,
  ) = _AuthenticatorFailureLogIn;
}

/// A union of [AuthenticatorCubit]'s states.
@freezed
class AuthenticatorState with _$AuthenticatorState {
  /// An [AuthenticatorCubit] state that indicates that an accion is being
  /// performed.
  const factory AuthenticatorState.loading() = _AuthenticatorStateLoading;

  /// An [AuthenticatorCubit] state that indicates that the user has been
  /// authenticated.
  const factory AuthenticatorState.authenticated() =
      _AuthenticatorStateAuthenticated;

  /// A [AuthenticatorCubit] state that indicates that the user is not
  /// authenticated.
  const factory AuthenticatorState.unauthenticated() =
      _AuthenticatorStateUnauthenticated;

  /// A [AuthenticatorCubit] state that indicates that a failure occurred during
  /// an auth process.
  ///
  /// [failure] is the holder of the actual failure.
  const factory AuthenticatorState.failure(
    AuthenticatorFailure failure,
  ) = _AuthenticatorStateFailure;
}
