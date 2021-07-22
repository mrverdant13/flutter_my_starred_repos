import 'package:dio/dio.dart';

import '../data_sources/etags_lds/interface.dart';

class EtagsInterceptor extends Interceptor {
  EtagsInterceptor({
    required PagesEtagsLDS pagesEtagsLDS,
  }) : _pagesEtagsLDS = pagesEtagsLDS;

  final PagesEtagsLDS _pagesEtagsLDS;

  static const extraEntry = MapEntry('etags_interceptor', true);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[extraEntry.key] == extraEntry.value) {
      final page = options.queryParameters['page'];
      if (page is int) {
        final etag = await _pagesEtagsLDS.get(
          page: page,
        );
        if (etag != null) {
          options.headers.addAll(
            {
              'If-None-Match': etag,
            },
          );
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final etag = response.headers['ETag']?.first;
    if (etag != null) {
      final page = response.requestOptions.queryParameters['page'];
      if (page is int) {
        await _pagesEtagsLDS.set(
          page: page,
          etag: etag,
        );
      }
    }
    super.onResponse(response, handler);
  }
}
