part of 'auth.cubit.dart';

@freezed
class AuthState with _$AuthState {
  // HACK: Ignoring Freezed factory constructors since they do not get marked as
  // covered.

  // coverage:ignore-start
  const factory AuthState.loading({
    required bool isLoggedIn,
  }) = _AuthStateLoading;
  const factory AuthState.loaded({
    required bool isLoggedIn,
  }) = _AuthStateLoaded;
  const factory AuthState.failure({
    required bool isLoggedIn,
    required AuthFailure failure,
  }) = _AuthStateFailure;
  // coverage:ignore-end
}
