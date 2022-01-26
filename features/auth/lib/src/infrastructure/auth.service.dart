import 'package:auth/src/domain/login_failure.dart';
import 'package:auth/src/domain/login_method.dart';
import 'package:auth/src/infrastructure/creds.storage.dart';
import 'package:auth/src/infrastructure/github_auth.api.dart';
import 'package:oauth2/oauth2.dart';
import 'package:oxidized/oxidized.dart';
import 'package:profile/profile.dart';

class AuthService {
  const AuthService({
    required GithubAuthApi githubAuthApi,
    required CredsStorage credsStorage,
    required ProfileApi profileApi,
    required ProfileStorage profileStorage,
  })  : _githubAuthApi = githubAuthApi,
        _credsStorage = credsStorage,
        _profileApi = profileApi,
        _profileStorage = profileStorage;

  final GithubAuthApi _githubAuthApi;
  final CredsStorage _credsStorage;
  final ProfileApi _profileApi;
  final ProfileStorage _profileStorage;

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

      // Fetches and stores the user's profile.
      final profile = await _profileApi.getProfile();
      await _profileStorage.setProfile(profile);

      return Ok(unit);
    } on LogInException catch (e) {
      return Err(
        e.when(
          canceled: () => const LoginFailure.canceled(),
          missingPermissions: () => const LoginFailure.missingPermissions(),
          offline: () => const LoginFailure.offline(),
        ),
      );
    } catch (_) {
      return Err(const LoginFailure.unexpected());
    }
  }

  Future<void> logOut() async {
    // TODO: Revoke credentials.
    await _credsStorage.clear();
  }
}
