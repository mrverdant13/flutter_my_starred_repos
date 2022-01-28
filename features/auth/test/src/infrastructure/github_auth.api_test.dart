import 'dart:io';

import 'package:auth/src/domain/github_auth_config.dart';
import 'package:auth/src/infrastructure/github_auth.api.dart';
import 'package:auth/src/infrastructure/oauth_response_handler_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';

class MockAuthorizationCodeGrant extends Mock
    implements AuthorizationCodeGrant {}

class MockHttpClient extends Mock implements http.Client {}

class MockOauthResponseHandlerWrapper extends Mock
    implements OauthResponseHandlerWrapper {}

class FakeAuthorizationCodeGrant extends Mock
    implements AuthorizationCodeGrant {}

class FakeRequest extends Fake implements http.BaseRequest {}

void main() {
  group(
    '''

GIVEN a github auth api
├─ THAT uses a GitHub config data holder''',
    () {
      // ARRANGE
      late GithubAuthConfig githubAuthConfig;
      late MockOauthResponseHandlerWrapper oauthResponseHandlerWrapper;
      // late Future<Client> Function() authResponseHandlerCallback;
      late GithubAuthApi githubAuthApi;

      setUpAll(
        () {
          registerFallbackValue(FakeAuthorizationCodeGrant());
          registerFallbackValue(Uri());
        },
      );

      setUp(
        () {
          githubAuthConfig = const GithubAuthConfig(
            clientId: 'clientId',
            clientSecret: 'clientSecret',
          );
          oauthResponseHandlerWrapper = MockOauthResponseHandlerWrapper();
          githubAuthApi = GithubAuthApi(
            githubAuthConfig: githubAuthConfig,
            oauthResponseHandlerWrapper: oauthResponseHandlerWrapper,
          );
        },
      );

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
            scopes: GithubAuthApi.expectedReturnedScopes,
          );
          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async =>
              redirectBaseEndpoint;

          when(
            () => oauthResponseHandlerWrapper.call(
              grant: any(named: 'grant'),
              redirectEndpoint: any(named: 'redirectEndpoint'),
            ),
          ).thenAnswer(
            (_) async => Client(creds),
          );

          // ACT
          final result = await githubAuthApi.logInWithOAuth(
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
          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async =>
              redirectBaseEndpoint;

          when(
            () => oauthResponseHandlerWrapper.call(
              grant: any(named: 'grant'),
              redirectEndpoint: any(named: 'redirectEndpoint'),
            ),
          ).thenAnswer(
            (_) async => Client(creds),
          );

          // ACT
          Future<Credentials> action() => githubAuthApi.logInWithOAuth(
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
            scopes: GithubAuthApi.expectedReturnedScopes,
          );
          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async =>
              null;

          when(
            () => oauthResponseHandlerWrapper.call(
              grant: any(named: 'grant'),
              redirectEndpoint: any(named: 'redirectEndpoint'),
            ),
          ).thenAnswer(
            (_) async => Client(creds),
          );

          // ACT
          Future<Credentials> action() => githubAuthApi.logInWithOAuth(
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
          Future<Uri?> oauthCallback({
            required Uri authorizationEndpoint,
            required Uri redirectBaseEndpoint,
          }) async {
            return redirectBaseEndpoint;
          }

          when(
            () => oauthResponseHandlerWrapper.call(
              grant: any(named: 'grant'),
              redirectEndpoint: any(named: 'redirectEndpoint'),
            ),
          ).thenThrow(
            AuthorizationException('error', null, null),
          );

          // ACT
          Future<Credentials> action() => githubAuthApi.logInWithOAuth(
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
      registerFallbackValue(FakeRequest());
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
