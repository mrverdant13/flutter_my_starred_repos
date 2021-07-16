import 'dart:io';

import 'package:flutter_app_template/core/config.dart';
import 'package:flutter_app_template/features/auth/infrastructure/data_sources/authenticator/github.dart';
import 'package:flutter_app_template/features/auth/infrastructure/data_sources/authenticator/interface.dart';
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
WHEN the reponse is handled
THEN the grant handler is used
AND the redirect endpoint query parameters is used
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
      expect(result, client);
      verify(
        () => mockGrant.handleAuthorizationResponse(
          redirectEndpoint.queryParameters,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockGrant);
    },
  );

  group(
    '''

GIVEN an authenticator
AND a GitHub config data holder''',
    () {
      // Config
      const githubAuthConfig = GithubAuthConfig(
        clientId: 'clientId',
        clientSecret: 'clientSecret',
      );

      // Remota data source
      late AuthenticatorImp authenticator;

      test(
        '''

WHEN the OAuth login process is triggered
AND the user grants all permissions
AND the user completes the process
THEN new credentials are returned
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
THEN an exception indicating permission issues is thrown
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
THEN an exception indicating that the action was canceled is thrown
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
THEN an exception indicating permission issues is thrown
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

  setUpAll(
    () {
      registerFallbackValue<http.BaseRequest>(FakeRequest());
    },
  );

  test(
    '''

GIVEN an OAuth HTTP client
WHEN it sends a request
THEN the `Accept` header is set to `application/json`
''',
    () async {
      // ARRANGE
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
