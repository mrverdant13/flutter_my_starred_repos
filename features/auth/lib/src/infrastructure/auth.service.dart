import 'package:auth/auth.dart';
import 'package:oauth2/oauth2.dart';
import 'package:oxidized/oxidized.dart';

class AuthService {
  const AuthService({
    required GithubAuthApi githubAuthApi,
    required CredsStorage credsStorage,
  })  : _githubAuthApi = githubAuthApi,
        _credsStorage = credsStorage;

  final GithubAuthApi _githubAuthApi;
  final CredsStorage _credsStorage;

  Future<bool> isLoggedIn() => _credsStorage.get().then(
        (creds) => creds != null,
      );

  Future<Result<Unit, LoginFailure>> logIn({
    required LoginMethod method,
  }) async {
    try {
      // Logs in according to the provided method.
      final creds = await method.when<Future<Credentials>>(
        oAuth: (callback) => _githubAuthApi.logInWithOAuth(
          callback: callback,
        ),
      );
      // Stores the obtained credentials.
      await _credsStorage.set(creds);
      return Ok(unit);
    } on LogInException catch (e) {
      return Err(
        e.when(
          canceled: () => const LoginFailure.canceled(),
          missingPermissions: () => const LoginFailure.missingPermissions(),
          offline: () => const LoginFailure.offline(),
        ),
      );
    }
  }

  Future<void> logOut() async {
    // TODO: Revoke credentials.
    await _credsStorage.clear();
  }
}
