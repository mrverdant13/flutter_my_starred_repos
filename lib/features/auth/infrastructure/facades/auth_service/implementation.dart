import 'package:creds_lds/creds_lds.dart';
import 'package:dartz/dartz.dart';
import 'package:oauth2/oauth2.dart';

import '../../../domain/log_in_failure.dart';
import '../../../domain/log_in_method.dart';
import '../../data_sources/authenticator/interface.dart';
import 'interface.dart';

/// An authentication service implementation.
class AuthServiceImp extends AuthService {
  /// Creates an authentication service with the given [authenticator] and
  /// [credsLDS].
  const AuthServiceImp({
    required Authenticator authenticator,
    required CredsLDS credsLDS,
  })  : _authenticator = authenticator,
        _credsLDS = credsLDS;

  /// The [Authenticator] to be used for the authentication process.
  final Authenticator _authenticator;

  /// The [CredsLDS] to be used to store an access credentials.
  final CredsLDS _credsLDS;

  @override
  Future<bool> isLoggedIn() => _credsLDS.get().then(
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
      await _credsLDS.set(creds);
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
    await _credsLDS.clear();
  }
}
