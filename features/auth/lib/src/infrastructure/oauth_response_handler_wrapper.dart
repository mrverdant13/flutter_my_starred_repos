import 'package:oauth2/oauth2.dart';

typedef AuthResponseHandlerCallback = Future<Client> Function({
  required AuthorizationCodeGrant grant,
  required Uri redirectEndpoint,
});

class OauthResponseHandlerWrapper {
  const OauthResponseHandlerWrapper();

  Future<Client> call({
    required AuthorizationCodeGrant grant,
    required Uri redirectEndpoint,
  }) =>
      grant.handleAuthorizationResponse(
        redirectEndpoint.queryParameters,
      );
}
