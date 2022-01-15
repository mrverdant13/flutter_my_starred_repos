import 'package:dio/dio.dart';
import 'package:starred_repos/starred_repos.dart';

class EtagsInterceptor extends Interceptor {
  EtagsInterceptor({
    required PageEtagsStorage pageEtagsStorage,
  }) : _pageEtagsStorage = pageEtagsStorage;

  final PageEtagsStorage _pageEtagsStorage;

  static const extraEntry = MapEntry('etags_interceptor', true);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[extraEntry.key] == extraEntry.value) {
      final page = options.queryParameters['page'];
      if (page is int) {
        final etag = await _pageEtagsStorage.get(
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
        await _pageEtagsStorage.set(
          page: page,
          etag: etag,
        );
      }
    }
    super.onResponse(response, handler);
  }
}
