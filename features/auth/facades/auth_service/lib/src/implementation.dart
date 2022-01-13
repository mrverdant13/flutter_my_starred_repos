import 'package:auth/auth.dart';
import 'package:auth_rds/auth_rds.dart';
import 'package:dartz/dartz.dart';
import 'package:oauth2/oauth2.dart';

import 'interface.dart';

/// An authentication service implementation.
class AuthServiceImp extends AuthService {
  /// Creates an authentication service with the given [authenticator] and
  /// [credsStorage].
  const AuthServiceImp({
    required Authenticator authenticator,
    required CredsStorage credsStorage,
  })  : _authenticator = authenticator,
        _credsStorage = credsStorage;

  /// The [Authenticator] to be used for the authentication process.
  final Authenticator _authenticator;

  /// The [CredsStorage] to be used to store an access credentials.
  final CredsStorage _credsStorage;

  @override
  Future<bool> isLoggedIn() => _credsStorage.get().then(
        (creds) => creds != null,
      );

  @override
  Future<Either<LoginFailure, Unit>> logIn({
    required LoginMethod method,
  }) async {
    try {
      // Logs in according to the provided method.
      final creds = await method.when<Future<Credentials>>(
        oAuth: (callback) => _authenticator.logInWithOAuth(
          callback: callback,
        ),
      );
      // Stores the obtained credentials.
      await _credsStorage.set(creds);
      return const Right(unit);
    } on LogInException catch (e) {
      return Left(
        e.when(
          canceled: () => const LoginFailure.canceled(),
          missingPermissions: () => const LoginFailure.missingPermissions(),
          offline: () => const LoginFailure.offline(),
        ),
      );
    }
  }

  @override
  Future<void> logOut() async {
    // TODO: Revoke credentials.
    await _credsStorage.clear();
  }
}
