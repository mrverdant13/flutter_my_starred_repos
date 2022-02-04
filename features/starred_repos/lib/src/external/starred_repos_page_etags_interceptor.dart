import 'package:dio/dio.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.api.dart';
import 'package:starred_repos/src/infrastructure/starred_repos_page_etags.storage.dart';

class StarredReposPageEtagsInterceptor extends Interceptor {
  StarredReposPageEtagsInterceptor({
    required StarredReposPageEtagsStorage starredReposPageEtagsStorage,
  }) : _starredReposPageEtagsStorage = starredReposPageEtagsStorage;

  final StarredReposPageEtagsStorage _starredReposPageEtagsStorage;

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
        final etag = await _starredReposPageEtagsStorage.get(
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
          await _starredReposPageEtagsStorage.set(
            page: page,
            etag: etag,
          );
        }
      }
    }
    super.onResponse(response, handler);
  }
}
