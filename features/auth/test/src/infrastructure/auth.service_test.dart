import 'dart:math';

import 'package:auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';
import 'package:oxidized/oxidized.dart';

class MockGithubAuthApi extends Mock implements GithubAuthApi {}

class MockCredsStorage extends Mock implements CredsStorage {}

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
    },
  );

  group(
    '''

GIVEN an auth service
├─ THAT uses a GitHub auth api
├─ AND  uses a credentials storage''',
    () {
      // ARRANGE
      late MockGithubAuthApi mockGithubAuthApi;
      late MockCredsStorage mockCredsStorage;
      late AuthService authService;

      setUp(
        () {
          mockGithubAuthApi = MockGithubAuthApi();
          mockCredsStorage = MockCredsStorage();
          authService = AuthService(
            githubAuthApi: mockGithubAuthApi,
            credsStorage: mockCredsStorage,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockGithubAuthApi);
          verifyNoMoreInteractions(mockCredsStorage);
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
THEN the user should be authenticated and his/her creds should be persisted
├─ BY collecting creds with the GitHub auth api
├─ AND storing the creds with the credentials storage
├─ AND not returning any data
''',
        () async {
          // ARRANGE
          final creds = Credentials('');
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

          // ACT
          final result = await authService.logIn(
            method: const LoginMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          expect(result, Ok(unit));
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          verify(
            () => mockCredsStorage.set(creds),
          ).called(1);
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
          expect(
            result,
            Err(
              const LoginFailure.offline(),
            ),
          );
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
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
          expect(
            result,
            Err(
              const LoginFailure.missingPermissions(),
            ),
          );
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
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
├─ AND returning a failure indicating hat the action was canceled
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
          expect(
            result,
            Err(
              const LoginFailure.canceled(),
            ),
          );
          verify(
            () => mockGithubAuthApi.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
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
