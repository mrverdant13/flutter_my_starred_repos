import 'dart:math';

import 'package:auth/src/domain/login_failure.dart';
import 'package:auth/src/domain/login_method.dart';
import 'package:auth/src/infrastructure/auth.service.dart';
import 'package:auth/src/infrastructure/creds.storage.dart';
import 'package:auth/src/infrastructure/github_auth.api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';
import 'package:oxidized/oxidized.dart';
import 'package:profile/profile.dart';
import 'package:test/test.dart';

class MockGithubAuthApi extends Mock implements GithubAuthApi {}

class MockCredsStorage extends Mock implements CredsStorage {}

class MockProfileApi extends Mock implements ProfileApi {}

class MockProfileStorage extends Mock implements ProfileStorage {}

class FakeOAuthCallback {
  Future<Uri> call({
    required Uri authorizationEndpoint,
    required Uri redirectBaseEndpoint,
  }) =>
      Future.value(
        Uri(),
      );
}

class FakeCredentials extends Fake implements Credentials {}

class FakeProfile extends Fake implements Profile {}

Future<Uri> oauthCallback({
  required Uri authorizationEndpoint,
  required Uri redirectBaseEndpoint,
}) async =>
    redirectBaseEndpoint;

void main() {
  // ARRANGE
  setUpAll(
    () {
      registerFallbackValue(FakeOAuthCallback().call);
      registerFallbackValue(FakeCredentials());
      registerFallbackValue(FakeProfile());
    },
  );

  group(
    '''

GIVEN an auth service
├─ THAT uses a GitHub auth API
├─ AND  uses a credentials storage
├─ AND  uses a profile API
├─ AND  uses a profile storage''',
    () {
      // ARRANGE
      late MockGithubAuthApi mockGithubAuthApi;
      late MockCredsStorage mockCredsStorage;
      late MockProfileApi mockProfileApi;
      late MockProfileStorage mockProfileStorage;
      late AuthService authService;

      setUp(
        () {
          mockGithubAuthApi = MockGithubAuthApi();
          mockCredsStorage = MockCredsStorage();
          mockProfileApi = MockProfileApi();
          mockProfileStorage = MockProfileStorage();
          authService = AuthService(
            githubAuthApi: mockGithubAuthApi,
            credsStorage: mockCredsStorage,
            profileApi: mockProfileApi,
            profileStorage: mockProfileStorage,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockGithubAuthApi);
          verifyNoMoreInteractions(mockCredsStorage);
          verifyNoMoreInteractions(mockProfileApi);
          verifyNoMoreInteractions(mockProfileStorage);
        },
      );

      test(
        '''

WHEN the login status is checked
THEN the auth status should be returned
├─ BY retrieving it from the credentials storage
├─ AND returning its value
''',
        () async {
          // ARRANGE
          final expectedStatus = Random().nextBool();

          when(
            () => mockCredsStorage.get(),
          ).thenAnswer(
            (_) async => expectedStatus ? FakeCredentials() : null,
          );

          // ACT
          final result = await authService.isLoggedIn();

          // ASSERT
          expect(result, expectedStatus);
          verify(
            () => mockCredsStorage.get(),
          ).called(1);
        },
      );

      test(
        '''

AND a reliable Internet connection
WHEN an OAuth login is triggered
AND the user grants all permissions
AND the user completes the process
THEN the user should be authenticated and his/her creds and profile should be persisted
├─ BY collecting creds with the GitHub auth api
├─ AND storing the creds with the credentials storage
├─ AND retrieving the profile with the profile api
├─ AND storing the profile with the profile storage
├─ AND not returning any data
''',
        () async {
          // ARRANGE
          final creds = Credentials('');
          const profile = Profile(username: 'username', avatarUrl: 'avatarUrl');

          when(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: any(named: 'callback'),
            ),
          ).thenAnswer(
            (_) async => creds,
          );
          when(
            () => mockCredsStorage.set(any()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          when(
            () => mockProfileApi.getProfile(),
          ).thenAnswer(
            (_) => Future.value(profile),
          );
          when(
            () => mockProfileStorage.setProfile(any()),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await authService.logIn(
            method: const LoginMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          verify(() => mockCredsStorage.set(creds)).called(1);
          verify(() => mockProfileApi.getProfile()).called(1);
          verify(() => mockProfileStorage.setProfile(profile)).called(1);
          expect(result, Ok<Unit, LoginFailure>(unit));
        },
      );

      test(
        '''

AND no Internet connection
WHEN an OAuth login is triggered
AND the user grants all permissions
AND the user completes the process
THEN the auth intent should result in a failure
├─ BY trying to collect creds with the GitHub auth api
├─ AND returning a failure indicating connectivity issues
''',
        () async {
          // ARRANGE
          when(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: any(named: 'callback'),
            ),
          ).thenThrow(
            const LogInException.offline(),
          );

          // ACT
          final result = await authService.logIn(
            method: const LoginMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          expect(
            result,
            Err<Unit, LoginFailure>(
              const LoginFailure.offline(),
            ),
          );
        },
      );

      test(
        '''

AND a reliable Internet connection
WHEN a OAuth login is triggered
AND the user does not grant all permissions
AND the user completes the process
THEN the auth intent should result in a failure
├─ BY trying to collect creds with the GitHub auth api
├─ AND returning a failure indicating permission issues
''',
        () async {
          // ARRANGE
          when(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: any(named: 'callback'),
            ),
          ).thenThrow(
            const LogInException.missingPermissions(),
          );

          // ACT
          final result = await authService.logIn(
            method: const LoginMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          expect(
            result,
            Err<Unit, LoginFailure>(
              const LoginFailure.missingPermissions(),
            ),
          );
        },
      );

      test(
        '''

AND a reliable Internet connection
WHEN a OAuth login is triggered
AND the user grants all permissions
AND the user does not complete the process
THEN the auth intent should result in a failure
├─ BY trying to collect creds with the GitHub auth api
├─ AND returning a failure indicating that the action was canceled
''',
        () async {
          // ARRANGE
          when(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: any(named: 'callback'),
            ),
          ).thenThrow(
            const LogInException.canceled(),
          );

          // ACT
          final result = await authService.logIn(
            method: const LoginMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          expect(
            result,
            Err<Unit, LoginFailure>(
              const LoginFailure.canceled(),
            ),
          );
        },
      );

      test(
        '''

AND unexpected conditions
WHEN a OAuth login is triggered
THEN the auth intent should result in a failure
├─ BY returning a failure indicating unexpected issues
''',
        () async {
          // ARRANGE
          when(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: any(named: 'callback'),
            ),
          ).thenThrow(
            Exception('Unexpected condition'),
          );

          // ACT
          final result = await authService.logIn(
            method: const LoginMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          expect(
            result,
            Err<Unit, LoginFailure>(
              const LoginFailure.unexpected(),
            ),
          );
        },
      );

      test(
        '''

WHEN the logout process is triggered
THEN any stored creds should be removed
├─ BY clearing the creds storage
├─ AND not returning any data
''',
        () async {
          // ARRANGE
          when(
            () => mockCredsStorage.clear(),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          await authService.logOut();

          // ASSERT
          verify(
            () => mockCredsStorage.clear(),
          ).called(1);
        },
      );
    },
  );
}
