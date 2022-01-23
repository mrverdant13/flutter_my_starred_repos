part of 'auth.cubit.dart';

@freezed
class AuthenticatorFailure with _$AuthenticatorFailure {
  const factory AuthenticatorFailure.logIn(
    LoginFailure failure,
  ) = _AuthenticatorFailureLogIn;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading({
    required bool isLoggedIn,
  }) = _AuthStateLoading;
  const factory AuthState.loaded({
    required bool isLoggedIn,
  }) = _AuthStateLoaded;
  const factory AuthState.failure({
    required bool isLoggedIn,
    required AuthenticatorFailure failure,
  }) = _AuthStateFailure;
}
