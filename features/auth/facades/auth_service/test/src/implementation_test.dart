import 'dart:math';

import 'package:auth_domain/auth_domain.dart';
import 'package:auth_rds/auth_rds.dart';
import 'package:auth_service/auth_service.dart';
import 'package:creds_lds/creds_lds.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';
import 'package:test/test.dart';

class MockAuthenticator extends Mock implements Authenticator {}

class MockCredsLDS extends Mock implements CredsLDS {}

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
├─ THAT uses an authenticator
├─ AND  uses a credentials local data source''',
    () {
      // ARRANGE
      late MockAuthenticator mockAuthenticator;
      late MockCredsLDS mockCredsLDS;
      late AuthServiceImp authService;

      setUp(
        () {
          mockAuthenticator = MockAuthenticator();
          mockCredsLDS = MockCredsLDS();
          authService = AuthServiceImp(
            authenticator: mockAuthenticator,
            credsLDS: mockCredsLDS,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockAuthenticator);
          verifyNoMoreInteractions(mockCredsLDS);
        },
      );

      test(
        '''

WHEN the login status is checked
THEN the auth status should be returned
├─ BY retrieving it from the credentials local data source
├─ AND returning its value
''',
        () async {
          // ARRANGE
          final expectedStatus = Random().nextBool();

          when(
            () => mockCredsLDS.get(),
          ).thenAnswer(
            (_) async => expectedStatus ? FakeCredentials() : null,
          );

          // ACT
          final result = await authService.isLoggedIn();

          // ASSERT
          expect(result, expectedStatus);
          verify(
            () => mockCredsLDS.get(),
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
├─ BY collecting creds with the authenticator
├─ AND storing the creds with the credentials local data source
├─ AND not returning any data
''',
        () async {
          // ARRANGE
          final creds = Credentials('');
          when(
            () => mockAuthenticator.logInWithOAuth(
              callback: any(named: 'callback'),
            ),
          ).thenAnswer(
            (_) async => creds,
          );
          when(
            () => mockCredsLDS.set(any()),
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
          expect(result, const Right(unit));
          verify(
            () => mockAuthenticator.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          verify(
            () => mockCredsLDS.set(creds),
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
├─ BY trying to collect creds with the authenticator
├─ AND returning a failure indicating connectivity issues
''',
        () async {
          // ARRANGE
          when(
            () => mockAuthenticator.logInWithOAuth(
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
            const Left(
              LoginFailure.offline(),
            ),
          );
          verify(
            () => mockAuthenticator.logInWithOAuth(
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
├─ BY trying to collect creds with the authenticator
├─ AND returning a failure indicating permission issues
''',
        () async {
          // ARRANGE
          when(
            () => mockAuthenticator.logInWithOAuth(
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
            const Left(
              LoginFailure.missingPermissions(),
            ),
          );
          verify(
            () => mockAuthenticator.logInWithOAuth(
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
├─ BY trying to collect creds with the authenticator
├─ AND returning a failure indicating hat the action was canceled
''',
        () async {
          // ARRANGE
          when(
            () => mockAuthenticator.logInWithOAuth(
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
            const Left(
              LoginFailure.canceled(),
            ),
          );
          verify(
            () => mockAuthenticator.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
        },
      );

      test(
        '''

WHEN the logout process is triggered
THEN any stored creds should be removed
├─ BY clearing the creds local data source
├─ AND not returning any data
''',
        () async {
          // ARRANGE
          when(
            () => mockCredsLDS.clear(),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          await authService.logOut();

          // ASSERT
          verify(
            () => mockCredsLDS.clear(),
          ).called(1);
        },
      );
    },
  );
}
