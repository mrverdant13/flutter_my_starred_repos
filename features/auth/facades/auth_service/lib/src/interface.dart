import 'package:auth/auth.dart';
import 'package:dartz/dartz.dart';

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
  Future<Either<LoginFailure, Unit>> logIn({
    required LoginMethod method,
  });

  /// Logs out a user.
  Future<void> logOut();
}
