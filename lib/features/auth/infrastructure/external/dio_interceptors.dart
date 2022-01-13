import 'package:auth/auth.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required CredsStorage credsStorage,
  }) : _credsStorage = credsStorage;

  final CredsStorage _credsStorage;

  static const extraEntry = MapEntry('auth_interceptor', true);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[extraEntry.key] == extraEntry.value) {
      final creds = await _credsStorage.get();
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
