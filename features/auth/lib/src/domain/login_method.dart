import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_method.freezed.dart';

typedef OAuthCallback = Future<Uri?> Function({
  required Uri authorizationEndpoint,
  required Uri redirectBaseEndpoint,
});

@freezed
class LoginMethod with _$LoginMethod {
  // coverage:ignore-start
  const factory LoginMethod.oAuth({
    required OAuthCallback callback,
  }) = _LoginMethodOAuth;
  // coverage:ignore-end
}
