import 'dart:math';

import 'package:auth/src/domain/login_failure.dart';
import 'package:auth/src/domain/login_method.dart';
import 'package:auth/src/infrastructure/auth.service.dart';
import 'package:auth/src/state/auth.notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:test/test.dart';

class MockAuthService extends Mock implements AuthService {}

class FakeLogInMethod extends Fake implements LoginMethod {}

void main() {
  // ARRANGE
  setUpAll(
    () {
      registerFallbackValue(FakeLogInMethod());
    },
  );

  group(
    '''

GIVEN an auth notifier
├─ THAT uses an auth service''',
    () {
      // ARRANGE
      late MockAuthService mockAuthService;
      late AuthNotifier authNotifier;

      setUp(
        () {
          mockAuthService = MockAuthService();
          authNotifier = AuthNotifier(
            authService: mockAuthService,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockAuthService);
        },
      );

      test(
        '''

WHEN no interaction
THEN its initial state should be loading and not logged in
''',
        () async {
          // ASSERT
          expect(authNotifier.isLoading, isTrue);
          expect(
            authNotifier.debugState,
            const AuthState.loading(isLoggedIn: false),
          );
        },
      );

      test(
        '''

WHEN the login status is requested
THEN the load process should be started
├─ BY emitting the loading status
├─ AND retrieving the status with the auth service
THEN the auth state should be updated
├─ BY emitting the resulting status
      ''',
        () async {
          // ARRANGE
          final r = Random();
          final isAuthenticated = r.nextBool();
          final expectedAuthState =
              AuthState.loaded(isLoggedIn: isAuthenticated);

          when(
            () => mockAuthService.isLoggedIn(),
          ).thenAnswer(
            (_) async => isAuthenticated,
          );

          final states = <AuthState>[];
          authNotifier.addListener(
            (authState) => states.add(authState),
            fireImmediately: false,
          );

          // ACT
          await authNotifier.checkAuthStatus();

          // ASSERT
          expect(
            states,
            [
              const AuthState.loading(isLoggedIn: false),
              expectedAuthState,
            ],
          );
          verify(
            () => mockAuthService.isLoggedIn(),
          ).called(1);
        },
      );

      test(
        '''

AND login minimal conditions
AND a login method
WHEN the login action is triggered
THEN the login process should be started
├─ BY emitting the loading status
├─ AND logging in with the auth service
│  ├─ THAT uses the given method
THEN the user should be authenticated
├─ BY emitting the authenticated status
''',
        () async {
          // ARRANGE
          final r = Random();
          final possibleLoginMethods = [
            LoginMethod.oAuth(
              callback: ({
                required authorizationEndpoint,
                required redirectBaseEndpoint,
              }) async =>
                  redirectBaseEndpoint,
            ),
          ];
          final loginMethod = possibleLoginMethods[r.nextInt(
            possibleLoginMethods.length,
          )];

          when(
            () => mockAuthService.logIn(
              method: any(named: 'method'),
            ),
          ).thenAnswer(
            (_) async => Ok(unit),
          );

          final states = <AuthState>[];
          authNotifier.addListener(
            (authState) => states.add(authState),
            fireImmediately: false,
          );

          // ACT
          await authNotifier.logIn(method: loginMethod);

          // ASSERT
          expect(
            states,
            [
              const AuthState.loading(isLoggedIn: false),
              const AuthState.loaded(isLoggedIn: true),
            ],
          );
          verify(
            () => mockAuthService.logIn(
              method: loginMethod,
            ),
          ).called(1);
        },
      );

      test(
        '''

AND no login minimal conditions
AND a login method
WHEN the login action is triggered
THEN the login process should be started
├─ BY emitting the loading status
├─ AND logging in with the auth service
│  ├─ THAT uses the given method
THEN a failure should be reported
├─ BY emitting a wrapped login failure state
      ''',
        () async {
          // ARRANGE
          final r = Random();
          final possibleLoginMethods = [
            LoginMethod.oAuth(
              callback: ({
                required authorizationEndpoint,
                required redirectBaseEndpoint,
              }) async =>
                  redirectBaseEndpoint,
            ),
          ];
          final loginMethod = possibleLoginMethods[r.nextInt(
            possibleLoginMethods.length,
          )];
          const possibleLoginFailures = [
            LoginFailure.canceled(),
            LoginFailure.missingPermissions(),
            LoginFailure.offline(),
          ];
          final expectedLoginFailure = possibleLoginFailures[r.nextInt(
            possibleLoginFailures.length,
          )];

          when(
            () => mockAuthService.logIn(
              method: any(named: 'method'),
            ),
          ).thenAnswer(
            (_) async => Err(expectedLoginFailure),
          );

          final states = <AuthState>[];
          authNotifier.addListener(
            (authState) => states.add(authState),
            fireImmediately: false,
          );

          // ACT
          await authNotifier.logIn(method: loginMethod);

          // ASSERT
          expect(
            states,
            [
              const AuthState.loading(isLoggedIn: false),
              AuthState.failure(
                isLoggedIn: false,
                failure: AuthFailure.logIn(
                  expectedLoginFailure,
                ),
              ),
            ],
          );
          verify(
            () => mockAuthService.logIn(
              method: loginMethod,
            ),
          ).called(1);
        },
      );

      test(
        '''

AND logout minimal conditions
WHEN the logout action is triggered
THEN the logout process should be started
├─ BY emitting the loading state
├─ AND logging out with the auth service
THEN the user should be unauthenticated
├─ BY emitting the unauthenticated state
      ''',
        () async {
          // ARRANGE
          when(
            () => mockAuthService.logOut(),
          ).thenAnswer(
            (_) async => unit,
          );

          final states = <AuthState>[];
          authNotifier.addListener(
            (authState) => states.add(authState),
            fireImmediately: false,
          );

          // ACT
          await authNotifier.logOut();

          // ASSERT
          expect(
            states,
            [
              const AuthState.loading(isLoggedIn: false),
              const AuthState.loaded(isLoggedIn: false),
            ],
          );
          verify(
            () => mockAuthService.logOut(),
          ).called(1);
        },
      );
    },
  );
}
