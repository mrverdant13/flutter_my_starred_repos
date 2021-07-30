import 'dart:io';

import 'package:dio/dio.dart';

typedef ResponseBuilder = Response Function(RequestOptions options);

class MockerInterceptor extends Interceptor {
  MockerInterceptor({
    this.responseBuilder,
  });

  final ResponseBuilder? responseBuilder;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.resolve(
      responseBuilder?.call(options) ??
          Response(
            requestOptions: options,
            statusCode: HttpStatus.ok,
          ),
      true,
    );
  }
}
