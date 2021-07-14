import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_in_failure.freezed.dart';

/// A union of posible login failures.
@freezed
class LogInFailure with _$LogInFailure {
  /// A failure representing the auth process cancelation.
  const factory LogInFailure.canceled() = _LogInFailureCanceled;

  /// A failure representing the auth process finalization without all required
  /// permissions.
  const factory LogInFailure.missingPermissions() =
      _LogInFailureMissingPermissions;

  /// A failure representing no Internet connection.
  const factory LogInFailure.offline() = _LogInFailureOffline;
}
