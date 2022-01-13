import 'dart:math';

import 'package:auth/auth.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_my_starred_repos/features/auth/application/authenticator_cubit/authenticator_cubit.dart';
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

GIVEN a authenticator cubit
├─ THAT uses an auth service''',
    () {
      // ARRANGE
      late MockAuthService mockAuthService;
      late AuthenticatorCubit authCubit;

      setUp(
        () {
          mockAuthService = MockAuthService();
          authCubit = AuthenticatorCubit(
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
THEN its initial state should be loading
''',
        () async {
          // ASSERT
          expect(authCubit.state, const AuthenticatorState.loading());
        },
      );

      {
        final r = Random();
        final isAuthenticated = r.nextBool();
        final expectedAuthState = isAuthenticated
            ? const AuthenticatorState.authenticated()
            : const AuthenticatorState.unauthenticated();

        blocTest<AuthenticatorCubit, AuthenticatorState>(
          '''

WHEN the login status is requested
THEN the load process should be started
├─ BY emitting the loading status
├─ AND retrieving the status with the auth service
THEN the auth state should be updated
├─ BY emitting the resulting status
      ''',
          build: () {
            when(
              () => mockAuthService.isLoggedIn(),
            ).thenAnswer(
              (_) async => isAuthenticated,
            );

            return authCubit;
          },
          act: (cubit) {
            cubit.checkAuthStatus();
          },
          expect: () => [
            const AuthenticatorState.loading(),
            expectedAuthState,
          ],
          verify: (bloc) {
            verify(() => mockAuthService.isLoggedIn()).called(1);
          },
        );
      }

      {
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

        blocTest<AuthenticatorCubit, AuthenticatorState>(
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
          build: () {
            when(
              () => mockAuthService.logIn(
                method: any(named: 'method'),
              ),
            ).thenAnswer(
              (_) async => Ok(unit),
            );

            return authCubit;
          },
          act: (cubit) {
            cubit.logIn(
              method: loginMethod,
            );
          },
          expect: () => [
            const AuthenticatorState.loading(),
            const AuthenticatorState.authenticated(),
          ],
          verify: (bloc) {
            verify(
              () => mockAuthService.logIn(
                method: loginMethod,
              ),
            ).called(1);
          },
        );

        blocTest<AuthenticatorCubit, AuthenticatorState>(
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
          build: () {
            when(
              () => mockAuthService.logIn(
                method: any(named: 'method'),
              ),
            ).thenAnswer(
              (_) async => Err(expectedLoginFailure),
            );

            return authCubit;
          },
          act: (cubit) {
            cubit.logIn(
              method: loginMethod,
            );
          },
          expect: () => [
            const AuthenticatorState.loading(),
            AuthenticatorState.failure(
              AuthenticatorFailure.logIn(
                expectedLoginFailure,
              ),
            ),
          ],
          verify: (bloc) {
            verify(
              () => mockAuthService.logIn(
                method: loginMethod,
              ),
            ).called(1);
          },
        );

        blocTest<AuthenticatorCubit, AuthenticatorState>(
          '''

AND logout minimal conditions
WHEN the logout action is triggered
THEN the logout process should be started
├─ BY emitting the loading state
├─ AND logging out with the auth service
THEN the user should be unauthenticated
├─ BY emitting the unauthenticated state
      ''',
          build: () {
            when(
              () => mockAuthService.logOut(),
            ).thenAnswer(
              (_) async => unit,
            );

            return authCubit;
          },
          act: (cubit) {
            cubit.logOut();
          },
          expect: () => [
            const AuthenticatorState.loading(),
            const AuthenticatorState.unauthenticated(),
          ],
          verify: (bloc) {
            verify(
              () => mockAuthService.logOut(),
            ).called(1);
          },
        );
      }
    },
  );
}
