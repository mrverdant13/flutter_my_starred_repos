part of 'auth.cubit.dart';

@freezed
class AuthFailure with _$AuthFailure {
  // HACK: Ignoring Freezed factory constructors since they do not get marked as
  // covered.

  // coverage:ignore-start
  const factory AuthFailure.logIn(
    LoginFailure failure,
  ) = _AuthFailureLogIn;
  // coverage:ignore-end
}
