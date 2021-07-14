import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oauth2/oauth2.dart';

import '../../../domain/log_in_method.dart';

part 'interface.freezed.dart';

/// An authenticator interface.
abstract class Authenticator {
  /// Creates an authenticator interface.
  const Authenticator();

  /// Returns credentials by logging in with the OAuth method.
  ///
  /// Throws a [LogInException.canceled] exception when the auth process is
  /// canceled.
  ///
  /// Throws a [LogInException.missingPermissions] exception when the auth
  /// process finishes without all required permissions.
  ///
  /// Throws a [LogInException.offline] exception when there is no Internet
  /// connection.
  Future<Credentials> logInWithOAuth({
    required OAuthCallback callback,
  });
}

/// A union of exceptions thrown when logging in.
@freezed
class LogInException with _$LogInException {
  /// An exception thrown when the process is canceled.
  const factory LogInException.canceled() = _LogInExceptionCanceled;

  /// An exception thrown when the process finishes without all required
  /// permissions.
  const factory LogInException.missingPermissions() =
      _LogInExceptionMissingPermissions;

  /// An exception thrown when there is no Internet connection.
  const factory LogInException.offline() = _LogInExceptionOffline;
}
