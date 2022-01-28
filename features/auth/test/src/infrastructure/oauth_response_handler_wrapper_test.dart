import 'package:auth/src/infrastructure/oauth_response_handler_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';

class MockAuthorizationCodeGrant extends Mock
    implements AuthorizationCodeGrant {}

void main() {
  test(
    '''

GIVEN an OAuth response handler wrapper
WHEN the handler is invoqued
├─ THAT receives a code grant
├─ AND receives a redirect URI
THEN a client should be returned
├─ BY using the grant's handler
│  ├─ THAT uses the provided redirect endpoint
''',
    () async {
      // ARRANGE
      const oauthResponseHandlerWrapper = OauthResponseHandlerWrapper();
      final grant = MockAuthorizationCodeGrant();
      final redirectEndpoint = Uri(queryParameters: {'code': '123'});
      final client = Client(Credentials('accessToken'));

      when(
        () => grant.handleAuthorizationResponse(
          any(),
        ),
      ).thenAnswer(
        (_) async => client,
      );

      // ACT
      final result = await oauthResponseHandlerWrapper.call(
        grant: grant,
        redirectEndpoint: redirectEndpoint,
      );

      // ASSERT
      expect(result, client);
      verify(
        () => grant.handleAuthorizationResponse(
          redirectEndpoint.queryParameters,
        ),
      ).called(1);
      verifyNoMoreInteractions(grant);
    },
  );
}
