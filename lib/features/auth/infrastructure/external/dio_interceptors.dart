import 'package:creds_lds/creds_lds.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required CredsLDS credsLDS,
  }) : _credsLDS = credsLDS;

  final CredsLDS _credsLDS;

  static const extraEntry = MapEntry('auth_interceptor', true);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[extraEntry.key] == extraEntry.value) {
      final creds = await _credsLDS.get();
      final accessToken = creds?.accessToken;

      if (accessToken != null) {
        options.headers.addAll(
          {
            'Authorization': 'Bearer $accessToken',
          },
        );
      }
    }

    super.onRequest(options, handler);
  }
}
