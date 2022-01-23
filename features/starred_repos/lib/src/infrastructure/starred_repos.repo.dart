import 'package:starred_repos/starred_repos.dart';

class StarredReposRepo {
  const StarredReposRepo({
    required StarredReposApi starredReposApi,
    required StarredReposStorage starredReposStorage,
  })  : _starredReposApi = starredReposApi,
        _starredReposStorage = starredReposStorage;

  final StarredReposApi _starredReposApi;
  final StarredReposStorage _starredReposStorage;

  Future<Payload<Page<GithubRepo>, GetStaredReposWarning>> getStarredReposPage({
    required int page,
  }) async {
    late final Page<GithubRepo>? reposPage;

    try {
      reposPage = await _starredReposApi.getStarredReposPage(
        page: page,
      );
    } on GetStarredReposPageException catch (e) {
      final starredReposPage = await _starredReposStorage.get(
        page: page,
      );
      final cachedReposPage = starredReposPage ??
          Page<GithubRepo>(
            lastPage: page,
            elements: [],
          );
      return e.when(
        offline: () => Payload.withWarning(
          data: cachedReposPage,
          warning: const GetStaredReposWarning.offline(),
        ),
        unmodified: () => Payload(
          cachedReposPage,
        ),
      );
    }
    await _starredReposStorage.set(page: page, starredReposPage: reposPage);
    return Payload(reposPage);
  }
}
