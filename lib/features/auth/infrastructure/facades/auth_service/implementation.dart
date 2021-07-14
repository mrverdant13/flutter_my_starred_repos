import 'package:dartz/dartz.dart';
import 'package:oauth2/oauth2.dart';

import '../../../domain/log_in_failure.dart';
import '../../../domain/log_in_method.dart';
import '../../data_sources/authenticator/interface.dart';
import '../../data_sources/creds_storage/interface.dart';
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
  Future<Either<LogInFailure, Unit>> logIn({
    required LogInMethod method,
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
          canceled: () => const LogInFailure.canceled(),
          missingPermissions: () => const LogInFailure.missingPermissions(),
          offline: () => const LogInFailure.offline(),
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
