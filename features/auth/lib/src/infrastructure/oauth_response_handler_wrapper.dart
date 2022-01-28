import 'package:oauth2/oauth2.dart';

typedef AuthResponseHandlerCallback = Future<Client> Function({
  required AuthorizationCodeGrant grant,
  required Uri redirectEndpoint,
});

// coverage:ignore-start
class OauthResponseHandlerWrapper {
  const OauthResponseHandlerWrapper({
    required this.handler,
  });

  final AuthResponseHandlerCallback handler;
}

final defaultOauthResponseHandlerWrapper = OauthResponseHandlerWrapper(
  handler: ({
    required AuthorizationCodeGrant grant,
    required Uri redirectEndpoint,
  }) async =>
      grant.handleAuthorizationResponse(
    redirectEndpoint.queryParameters,
  ),
);
// coverage:ignore-end
