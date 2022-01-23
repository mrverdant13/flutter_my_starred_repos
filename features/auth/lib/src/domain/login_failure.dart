import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_failure.freezed.dart';

@freezed
class LoginFailure with _$LoginFailure {
  const factory LoginFailure.canceled() = _LoginFailureCanceled;
  const factory LoginFailure.missingPermissions() =
      _LoginFailureMissingPermissions;
  const factory LoginFailure.offline() = _LoginFailureOffline;
}
