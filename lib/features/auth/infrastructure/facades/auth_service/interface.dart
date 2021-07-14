import 'package:dartz/dartz.dart';

import '../../../domain/log_in_failure.dart';
import '../../../domain/log_in_method.dart';

/// An authentication service interface.
abstract class AuthService {
  /// Creates an authentication service interface.
  const AuthService();

  /// Checks if a user is logged in.
  ///
  /// Checks if credentials exist.
  Future<bool> isLoggedIn();

  /// Logs in a user with the given [method].
  ///
  /// Obtains and stores credentials.
  Future<Either<LogInFailure, Unit>> logIn({
    required LogInMethod method,
  });

  /// Logs out a user.
  Future<void> logOut();
}
