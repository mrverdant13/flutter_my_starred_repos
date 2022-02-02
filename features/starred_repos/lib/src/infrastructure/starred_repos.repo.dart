import 'package:starred_repos/src/domain/get_starred_repos_warnings.dart';
import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/domain/page.dart';
import 'package:starred_repos/src/domain/payload.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.api.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.storage.dart';

class StarredReposRepo {
  const StarredReposRepo({
    required StarredReposApi starredReposApi,
    required StarredReposStorage starredReposStorage,
  })  : _starredReposApi = starredReposApi,
        _starredReposStorage = starredReposStorage;

  final StarredReposApi _starredReposApi;
  final StarredReposStorage _starredReposStorage;

  Future<Payload<Page<GithubRepo>, GetStaredReposWarning>> getStarredReposPage({
    required int pageNumber,
    required int pageLength,
  }) async {
    late final Page<GithubRepo>? reposPage;

    try {
      reposPage = await _starredReposApi.getStarredReposPage(
        pageNumber: pageNumber,
        pageLength: pageLength,
      );
    } on GetStarredReposPageException catch (e) {
      final starredReposPage = await _starredReposStorage.get(
        pageNumber: pageNumber,
        pageLength: pageLength,
      );
      final cachedReposPage = starredReposPage ??
          Page<GithubRepo>(
            lastPage: pageNumber,
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
    await _starredReposStorage.set(
      pageNumber: pageNumber,
      starredReposPage: reposPage,
    );
    return Payload(reposPage);
  }
}
