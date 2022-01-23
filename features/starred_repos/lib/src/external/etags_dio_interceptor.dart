import 'package:dio/dio.dart';
import 'package:starred_repos/src/infrastructure/page_etags.storage.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.api.dart';

class EtagsInterceptor extends Interceptor {
  EtagsInterceptor({
    required PageEtagsStorage pageEtagsStorage,
  }) : _pageEtagsStorage = pageEtagsStorage;

  final PageEtagsStorage _pageEtagsStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requestUrl = options.uri.toString();
    final isRequestingStarredRepos =
        requestUrl.contains(StarredReposApi.retrieveEndpoint);
    if (isRequestingStarredRepos) {
      final page = options.queryParameters['page'];
      if (page is int) {
        final etag = await _pageEtagsStorage.get(
          page: page,
        );
        if (etag != null) {
          options.headers.addAll({'If-None-Match': etag});
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
    final requestUrl = response.requestOptions.uri.toString();
    final isRequestingStarredRepos =
        requestUrl.contains(StarredReposApi.retrieveEndpoint);
    if (isRequestingStarredRepos) {
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
    }
    super.onResponse(response, handler);
  }
}
