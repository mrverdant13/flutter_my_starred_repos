import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/starred_repos_lds/interface.dart';
import 'package:starred_repos/starred_repos.dart';

import 'interface.dart';

/// A starred GitHub repositories repository implementation.
class StarredReposRepoImp extends StarredReposRepo {
  /// Creates a starred GitHub repositories repository with the given
  /// [starredReposApi].
  const StarredReposRepoImp({
    required StarredReposApi starredReposApi,
    required StarredReposLDS starredReposLDS,
  })  : _starredReposApi = starredReposApi,
        _starredReposLDS = starredReposLDS;

  /// The remota data source to be used to retrieve the starred GitHub
  /// repositories.
  final StarredReposApi _starredReposApi;
  final StarredReposLDS _starredReposLDS;

  @override
  Future<Payload<Page<GithubRepo>, GetStaredReposWarning>> getStarredReposPage({
    required int page,
  }) async {
    late final Page<GithubRepo>? reposPage;

    try {
      reposPage = await _starredReposApi.getStarredReposPage(
        page: page,
      );
    } on GetStarredReposPageException catch (e) {
      final starredReposPage = await _starredReposLDS.get(
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
    await _starredReposLDS.set(page: page, starredReposPage: reposPage);
    return Payload(reposPage);
  }
}
