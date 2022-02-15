part of 'auth.notifier.dart';

@freezed
class AuthFailure with _$AuthFailure {
  // coverage:ignore-start
  const factory AuthFailure.logIn(
    LoginFailure failure,
  ) = _AuthFailureLogIn;
  // coverage:ignore-end
}
