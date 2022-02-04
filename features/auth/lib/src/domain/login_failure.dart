import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_failure.freezed.dart';

@freezed
class LoginFailure with _$LoginFailure {
  // coverage:ignore-start
  const factory LoginFailure.canceled() = _LoginFailureCanceled;
  const factory LoginFailure.missingPermissions() =
      LoginFailureMissingPermissions;
  const factory LoginFailure.offline() = _LoginFailureOffline;
  const factory LoginFailure.unexpected() = _LoginFailureUnexpected;
  // coverage:ignore-end
}
