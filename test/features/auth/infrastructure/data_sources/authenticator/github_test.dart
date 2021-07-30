import 'dart:io';

import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/data_sources/authenticator/github.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/data_sources/authenticator/interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';
import 'package:http/http.dart' as http;

class MockAuthorizationCodeGrant extends Mock
    implements AuthorizationCodeGrant {}

class MockHttpClient extends Mock implements http.Client {}

class FakeRequest extends Fake implements http.BaseRequest {}

void main() {
  test(
    '''

GIVEN a grant-based auth response handler
AND a grant
AND a redirect endpoint
WHEN the reponse handler is invoked using the given grant and redirect endpoint
├─ BY calling the grant response handler
│  ├─ THAT uses the redirect endpoint query parameters
├─ AND an receiving an HTTP client wrapping the resulting credentials
''',
    () async {
      // ARRANGE
      final mockGrant = MockAuthorizationCodeGrant();
      final redirectEndpoint = Uri.parse('http://localhost').replace(
        queryParameters: {'param': 'param'},
      );
      final creds = Credentials('access_token');
      final client = Client(creds);

      when(
        () => mockGrant.handleAuthorizationResponse(
          any(),
        ),
      ).thenAnswer(
        (_) async => client,
      );

      // ACT
      final result = await handleAuthorizationResponse(
        grant: mockGrant,
        redirectEndpoint: redirectEndpoint,
      );

      // ASSERT
      verify(
        () => mockGrant.handleAuthorizationResponse(
          redirectEndpoint.queryParameters,
        ),
      ).called(1);
      expect(result, client);
      verifyNoMoreInteractions(mockGrant);
    },
  );

  group(
    '''

GIVEN an authenticator
AND a GitHub config data holder''',
    () {
      // ARRANGE
      const githubAuthConfig = GithubAuthConfig(
        clientId: 'clientId',
        clientSecret: 'clientSecret',
      );
      late AuthenticatorImp authenticator;

      test(
        '''

WHEN the OAuth login process is triggered
AND the user grants all permissions
AND the user completes the process
THEN the resulting creds should be returned
''',
        () async {
          // ARRANGE
          final creds = Credentials(
            'access_token',
            scopes: AuthenticatorImp.expectedReturnedScopes,
          );

          authenticator = AuthenticatorImp(
            githubAuthConfig: githubAuthConfig,
            authResponseHandlerCallback: ({
              required AuthorizationCodeGrant grant,
              required Uri redirectEndpoint,
            }) async {
              return Client(creds);
            },
          );

          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async {
            return redirectBaseEndpoint;
          }

          // ACT
          final result = await authenticator.logInWithOAuth(
            callback: oauthCallback,
          );

          // ASSERT
          expect(result.toJson(), creds.toJson());
        },
      );

      test(
        '''

WHEN the OAuth login process is triggered
AND the user does not grant all permissions
AND the user completes the process
THEN an exception indicating permission issues should be thrown
''',
        () async {
          // ARRANGE
          final creds = Credentials(
            'access_token',
          );

          authenticator = AuthenticatorImp(
            githubAuthConfig: githubAuthConfig,
            authResponseHandlerCallback: ({
              required AuthorizationCodeGrant grant,
              required Uri redirectEndpoint,
            }) async {
              return Client(creds);
            },
          );

          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async {
            return redirectBaseEndpoint;
          }

          // ACT
          Future<Credentials> action() => authenticator.logInWithOAuth(
                callback: oauthCallback,
              );

          // ASSERT
          expect(
            action,
            throwsA(
              const LogInException.missingPermissions(),
            ),
          );
        },
      );

      test(
        '''

WHEN the OAuth login process is triggered
AND the user grants all permissions
AND the user does not complete the process
THEN an exception indicating that the action was canceled should be thrown
''',
        () async {
          // ARRANGE
          final creds = Credentials(
            'access_token',
          );

          authenticator = AuthenticatorImp(
            githubAuthConfig: githubAuthConfig,
            authResponseHandlerCallback: ({
              required AuthorizationCodeGrant grant,
              required Uri redirectEndpoint,
            }) async {
              return Client(creds);
            },
          );

          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async {
            return null;
          }

          // ACT
          Future<Credentials> action() => authenticator.logInWithOAuth(
                callback: oauthCallback,
              );

          // ASSERT
          expect(
            action,
            throwsA(
              const LogInException.canceled(),
            ),
          );
        },
      );

      test(
        '''

WHEN the OAuth login process is triggered
AND the user grants all permissions
AND the user complete the process
AND the operation fails
THEN an exception indicating permission issues should be thrown
''',
        () async {
          // ARRANGE
          authenticator = AuthenticatorImp(
            githubAuthConfig: githubAuthConfig,
            authResponseHandlerCallback: ({
              required AuthorizationCodeGrant grant,
              required Uri redirectEndpoint,
            }) async {
              throw AuthorizationException(
                'error',
                null,
                null,
              );
            },
          );

          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async {
            return redirectBaseEndpoint;
          }

          // ACT
          Future<Credentials> action() => authenticator.logInWithOAuth(
                callback: oauthCallback,
              );

          // ASSERT
          expect(
            action,
            throwsA(
              const LogInException.missingPermissions(),
            ),
          );
        },
      );
    },
  );

  test(
    '''

GIVEN an OAuth HTTP client
├─ THAT uses an actual HTTP client
WHEN it sends a request
THEN the request dispatching shoul be delegated
├─ BY sending the request with the inner HTTP client
│  ├─ THAT sets the request `Accept` header to `application/json`
''',
    () async {
      // ARRANGE
      registerFallbackValue<http.BaseRequest>(FakeRequest());
      final mockHttpClient = MockHttpClient();
      final oauthHttpClient = OAuthHttpClient(
        mockHttpClient,
      );
      when(
        () => mockHttpClient.send(any()),
      ).thenAnswer(
        (Invocation invocation) async {
          final request =
              invocation.positionalArguments.first as http.BaseRequest;
          return http.StreamedResponse(
            const Stream.empty(),
            HttpStatus.ok,
            request: request,
          );
        },
      );

      // ACT
      final result = await oauthHttpClient.send(
        http.Request(
          'POST',
          Uri.parse('http://localhost'),
        ),
      );
      final headers = result.request!.headers;

      // ASSERT
      expect(headers['Accept'], 'application/json');
      verify(
        () => mockHttpClient.send(
          any<http.BaseRequest>(),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    },
  );
}
