import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_my_starred_repos/features/auth/domain/log_in_failure.dart';
import 'package:flutter_my_starred_repos/features/auth/domain/log_in_method.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/data_sources/authenticator/interface.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/data_sources/creds_storage/interface.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/facades/auth_service/implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';

class MockAuthenticator extends Mock implements Authenticator {}

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
  setUpAll(
    () {
      registerFallbackValue<OAuthCallback>(
        FakeOAuthCallback().call,
      );
      registerFallbackValue<Credentials>(
        FakeCredentials(),
      );
    },
  );

  group(
    '''

GIVEN an auth service implementation''',
    () {
      // Values
      late Credentials creds;

      // Data sources
      late MockAuthenticator mockAuthenticator;
      late MockCredsStorage mockCredsStorage;

      // Facades
      late AuthServiceImp authService;

      setUp(
        () {
          creds = FakeCredentials();

          mockAuthenticator = MockAuthenticator();
          mockCredsStorage = MockCredsStorage();

          authService = AuthServiceImp(
            authenticator: mockAuthenticator,
            credsStorage: mockCredsStorage,
          );
        },
      );

      test(
        '''

WHEN the login status is checked
THEN the status is returned
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
          verifyNoMoreInteractions(mockCredsStorage);
        },
      );

      test(
        '''

AND there is Internet connection
WHEN a OAuth login is triggered
AND the user grants all permissions
AND the user completes the process
THEN new credentials are obtained
AND the new credentials are stored
''',
        () async {
          // ARRANGE
          when(
            () => mockAuthenticator.logInWithOAuth(
              callback: any(named: 'callback'),
            ),
          ).thenAnswer(
            (_) async => creds,
          );
          when(
            () => mockCredsStorage.set(any()),
          ).thenAnswer(
            (_) async => 0,
          );

          // ACT
          final result = await authService.logIn(
            method: const LogInMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          expect(
            result,
            const Right(unit),
          );
          verify(
            () => mockAuthenticator.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          verify(
            () => mockCredsStorage.set(creds),
          ).called(1);
          verifyNoMoreInteractions(mockAuthenticator);
          verifyNoMoreInteractions(mockCredsStorage);
        },
      );

      test(
        '''

AND there is no Internet connection
WHEN a OAuth login is triggered
AND the user grants all permissions
AND the user completes the process
THEN an failure indicating connectivity issues is returned
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
            method: const LogInMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          expect(
            result,
            const Left(
              LogInFailure.offline(),
            ),
          );
          verify(
            () => mockAuthenticator.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAuthenticator);
        },
      );

      test(
        '''

AND there is Internet connection
WHEN a OAuth login is triggered
AND the user does not grant all permissions
AND the user completes the process
THEN a failure indicating permission issues is returned
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
            method: const LogInMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          expect(
            result,
            const Left(
              LogInFailure.missingPermissions(),
            ),
          );
          verify(
            () => mockAuthenticator.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAuthenticator);
        },
      );

      test(
        '''

AND there is Internet connection
WHEN a OAuth login is triggered
AND the user grants all permissions
AND the user does not complete the process
THEN a failure indicating that the action was canceled is returned
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
            method: const LogInMethod.oAuth(
              callback: oauthCallback,
            ),
          );

          // ASSERT
          expect(
            result,
            const Left(
              LogInFailure.canceled(),
            ),
          );
          verify(
            () => mockAuthenticator.logInWithOAuth(
              callback: oauthCallback,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAuthenticator);
        },
      );

      test(
        '''

WHEN the logout process is triggered
THEN the stored credentials are removed
''',
        () async {
          // ARRANGE
          when(
            () => mockCredsStorage.clear(),
          ).thenAnswer(
            (_) async => 0,
          );

          // ACT
          await authService.logOut();

          // ASSERT
          verify(
            () => mockCredsStorage.clear(),
          ).called(1);
          verifyNoMoreInteractions(mockCredsStorage);
        },
      );
    },
  );
}
