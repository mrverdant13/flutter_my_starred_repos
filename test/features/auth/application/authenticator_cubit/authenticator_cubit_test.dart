import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_my_starred_repos/features/auth/application/authenticator_cubit/authenticator_cubit.dart';
import 'package:flutter_my_starred_repos/features/auth/domain/log_in_failure.dart';
import 'package:flutter_my_starred_repos/features/auth/domain/log_in_method.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/facades/auth_service/interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthService extends Mock implements AuthService {}

class FakeLogInMethod extends Fake implements LogInMethod {}

void main() {
  setUpAll(
    () {
      registerFallbackValue<LogInMethod>(FakeLogInMethod());
    },
  );

  group(
    '''

GIVEN a authenticator cubit''',
    () {
      // Facades
      late MockAuthService mockAuthService;

      // Cubit
      late AuthenticatorCubit authCubit;

      setUp(
        () {
          mockAuthService = MockAuthService();
          authCubit = AuthenticatorCubit(
            authService: mockAuthService,
          );
        },
      );

      test(
        '''

WHEN no interaction
THEN its initial state is loading
''',
        () async {
          // ARRANGE

          // ACT

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
THEN the load process is started
THEN the auth status is emited
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
            verifyNoMoreInteractions(mockAuthService);
          },
        );
      }

      {
        final r = Random();
        final possibleLoginMethods = [
          LogInMethod.oAuth(
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
          LogInFailure.canceled(),
          LogInFailure.missingPermissions(),
          LogInFailure.offline(),
        ];
        final expectedLoginFailure = possibleLoginFailures[r.nextInt(
          possibleLoginFailures.length,
        )];

        blocTest<AuthenticatorCubit, AuthenticatorState>(
          '''

AND login minimal conditions
AND a login method
WHEN the login action is triggered
THEN the load process is started
THEN the user gets authenticated
      ''',
          build: () {
            when(
              () => mockAuthService.logIn(
                method: any(named: 'method'),
              ),
            ).thenAnswer(
              (_) async => const Right(unit),
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
            verify(() => mockAuthService.logIn(
                  method: loginMethod,
                )).called(1);
            verifyNoMoreInteractions(mockAuthService);
          },
        );

        blocTest<AuthenticatorCubit, AuthenticatorState>(
          '''

AND no login minimal conditions
AND a login method
WHEN the login action is triggered
THEN the load process is started
THEN a failure state is emited wrapping the actual login failure
      ''',
          build: () {
            when(
              () => mockAuthService.logIn(
                method: any(named: 'method'),
              ),
            ).thenAnswer(
              (_) async => Left(expectedLoginFailure),
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
            verify(() => mockAuthService.logIn(
                  method: loginMethod,
                )).called(1);
            verifyNoMoreInteractions(mockAuthService);
          },
        );

        blocTest<AuthenticatorCubit, AuthenticatorState>(
          '''

AND logout minimal conditions
WHEN the logout action is triggered
THEN the load process is started
THEN the user gets unauthenticated
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
            verify(() => mockAuthService.logOut()).called(1);
            verifyNoMoreInteractions(mockAuthService);
          },
        );
      }
    },
  );
}
