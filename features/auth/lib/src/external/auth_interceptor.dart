import 'package:auth/auth.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required CredsStorage credsStorage,
  }) : _credsStorage = credsStorage;

  final CredsStorage _credsStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final maybeCreds = await _credsStorage.get();
    final accessToken = maybeCreds?.accessToken;
    if (accessToken != null) {
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    super.onRequest(options, handler);
  }
}
