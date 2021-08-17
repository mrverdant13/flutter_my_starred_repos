import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_failure.freezed.dart';

/// A union of posible login failures.
@freezed
class LoginFailure with _$LoginFailure {
  /// A failure representing the auth process cancelation.
  const factory LoginFailure.canceled() = _LoginFailureCanceled;

  /// A failure representing the auth process finalization without all required
  /// permissions.
  const factory LoginFailure.missingPermissions() =
      _LoginFailureMissingPermissions;

  /// A failure representing no Internet connection.
  const factory LoginFailure.offline() = _LoginFailureOffline;
}
