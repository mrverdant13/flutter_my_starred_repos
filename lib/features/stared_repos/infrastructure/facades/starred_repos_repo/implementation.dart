import '../../../domain/get_starred_repos_warnings.dart';
import '../../../domain/page.dart';
import '../../../domain/payload.dart';
import '../../../domain/repo.dart';
import '../../converters/page.dart';
import '../../converters/repo.dart';
import '../../data_sources/stared_repos_rds/interface.dart';
import '../../data_sources/starred_repos_lds/interface.dart';
import '../../dtos/github_repo.dart';
import 'interface.dart';

/// A starred GitHub repositories repository implementation.
class StarredReposRepoImp extends StarredReposRepo {
  /// Creates a starred GitHub repositories repository with the given
  /// [starredReposRDS].
  const StarredReposRepoImp({
    required StaredReposRDS starredReposRDS,
    required StarredReposLDS starredReposLDS,
  })  : _starredReposRDS = starredReposRDS,
        _starredReposLDS = starredReposLDS;

  /// The remota data source to be used to retrieve the starred GitHub
  /// repositories.
  final StaredReposRDS _starredReposRDS;
  final StarredReposLDS _starredReposLDS;

  @override
  Future<Payload<Page<GithubRepo>, GetStaredReposWarning>> getStarredReposPage({
    required int page,
  }) async {
    late final Page<GithubRepoDto>? reposDtosPage;

    try {
      reposDtosPage = await _starredReposRDS.getStaredReposPage(
        page: page,
      );
    } on GetStaredReposPageException catch (e) {
      final starredReposDtosPage = await _starredReposLDS.get(
        page: page,
      );
      final cachedReposPage = starredReposDtosPage?.map<GithubRepo>(
            (reposDtos) => reposDtos.asEntity,
          ) ??
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

    await _starredReposLDS.set(page: page, starredReposPage: reposDtosPage);
    return Payload(
      reposDtosPage.map<GithubRepo>(
        (starredRepoDto) => starredRepoDto.asEntity,
      ),
    );
  }
}
