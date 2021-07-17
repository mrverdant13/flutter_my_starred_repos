import 'dart:io';

import 'package:dio/dio.dart';

class MockerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.resolve(
      Response(
        requestOptions: options,
        statusCode: HttpStatus.ok,
      ),
    );
  }
}
