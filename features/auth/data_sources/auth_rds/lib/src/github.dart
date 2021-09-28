import 'package:auth_config/auth_config.dart';
import 'package:auth_domain/auth_domain.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:oauth2/oauth2.dart';

import 'interface.dart';

typedef AuthResponseHandlerCallback = Future<Client> Function({
  required AuthorizationCodeGrant grant,
  required Uri redirectEndpoint,
});

@visibleForTesting
Future<Client> handleAuthorizationResponse({
  required AuthorizationCodeGrant grant,
  required Uri redirectEndpoint,
}) async {
  return grant.handleAuthorizationResponse(
    redirectEndpoint.queryParameters,
  );
}

/// An authenticator implementation that uses the GitHub API.
class AuthenticatorImp extends Authenticator {
  /// Creates an authenticator implementation.
  AuthenticatorImp({
    required GithubAuthConfig githubAuthConfig,
    AuthResponseHandlerCallback? authResponseHandlerCallback,
  })  : _authResponseHandlerCallback =
            authResponseHandlerCallback ?? handleAuthorizationResponse,
        _clientId = githubAuthConfig.clientId,
        _clientSecret = githubAuthConfig.clientSecret;

  final AuthResponseHandlerCallback _authResponseHandlerCallback;

  /// The endpoint that holds the base authorization URL and that is used to
  /// interact withthe user to get the authorization to access the protected
  /// resources.
  ///
  /// See: [OAuth 2.0 Authorization Endpoint]
  ///
  /// [OAuth 2.0 Authorization Endpoint]:
  /// https://auth0.com/docs/protocols/protocol-oauth2#authorization-endpoint
  static final _authorizationBaseEndpoint = Uri.parse(
    'https://github.com/login/oauth/authorize',
  );

  /// The endpoint used by this app in order to get an access token.
  ///
  /// See: [OAuth 2.0 Token Endpoint]
  ///
  /// [OAuth 2.0 Token Endpoint]:
  /// https://auth0.com/docs/protocols/protocol-oauth2#token-endpoint
  static final _tokenEndpoint = Uri.parse(
    'https://github.com/login/oauth/access_token',
  );

  /// The destination endpoint that holds the base redirect URL and that is
  /// where the user will be redirected to after a successful authorization
  /// process.
  ///
  /// See: [OAuth 2.0 Authorization Endpoint]
  ///
  /// [OAuth 2.0 Authorization Endpoint]:
  /// https://auth0.com/docs/protocols/protocol-oauth2#authorization-endpoint
  static final _redirectBaseEndpoint = Uri.parse(
    'http://localhost:3000/callback',
  );

  /// The identifier for this app, which asks for authorization.
  final String _clientId;

  /// The secret key for this app.
  final String _clientSecret;

  /// A list of permissions that this app requires.
  static const _scopes = [
    'read:user',
    'repo',
  ];
  @visibleForTesting
  static final expectedReturnedScopes = [_scopes.join(',')];

  /// Creates a grant holding data needed to obtain GitHub credentials via an
  /// [authorization code grant].
  ///
  /// GitHub uses the OAuth2 spec but for it to return JSON formatted
  /// credentials, an [_OAuthHttpClient] should be used to automatically set the
  /// `Accept` header to `application/json`.
  ///
  /// [authorization code grant]:
  /// https://auth0.com/docs/flows/authorization-code-flow
  AuthorizationCodeGrant _createGrant() => AuthorizationCodeGrant(
        _clientId,
        _authorizationBaseEndpoint,
        _tokenEndpoint,
        secret: _clientSecret,
        httpClient: OAuthHttpClient(),
      );

  /// Constructs the actual endpoint used to interact with the user to get the
  /// authorization to access the protected resources.
  ///
  /// It uses the [_authorizationBaseEndpoint] as base.
  ///
  /// See: [OAuth 2.0 Authorization Endpoint]
  ///
  /// [OAuth 2.0 Authorization Endpoint]:
  /// https://auth0.com/docs/protocols/protocol-oauth2#authorization-endpoint
  Uri _constructAuthorizationEndpoint({
    required AuthorizationCodeGrant grant,
  }) =>
      grant.getAuthorizationUrl(
        _redirectBaseEndpoint,
        scopes: _scopes,
      );

  @override
  Future<Credentials> logInWithOAuth({
    required OAuthCallback callback,
  }) async {
    // Create a new grant and its pertinent authorization endpoint.
    final grant = _createGrant();
    final authorizationEndpoint = _constructAuthorizationEndpoint(grant: grant);

    // Get the redirect endpoint that includes query params that holds auth data.
    final redirectEndpoint = await callback(
      authorizationEndpoint: authorizationEndpoint,
      redirectBaseEndpoint: _redirectBaseEndpoint,
    );

    // If the redirect does not exist, it means the process was canceled.
    if (redirectEndpoint == null) {
      throw const LogInException.canceled();
    }

    // Obtain the HTTP client used for the auth process and extract the creds
    // from it.
    late final Client httpClient;
    try {
      httpClient = await _authResponseHandlerCallback(
        grant: grant,
        redirectEndpoint: redirectEndpoint,
      );
    } on AuthorizationException {
      throw const LogInException.missingPermissions();
    }
    final creds = httpClient.credentials;

    // Check if all scopes were granted.
    if (!listEquals(creds.scopes, expectedReturnedScopes)) {
      throw const LogInException.missingPermissions();
    }

    grant.close();

    return creds;
  }
}

/// An HTTP client that sets the `Accept` header to `application/json` for every
/// request it performs.
@visibleForTesting
class OAuthHttpClient extends http.BaseClient {
  OAuthHttpClient([http.Client? client]) : _client = client ?? http.Client();

  /// The default HTTP client to be used for the authentication flow.
  final http.Client _client;

  /// Sends a request after adding the `Accept` header to use JSON format.
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return _client.send(request);
  }
}
