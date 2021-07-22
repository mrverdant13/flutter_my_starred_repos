import '../../../domain/page.dart';
import '../../dtos/github_repo.dart';

abstract class StarredReposLDS {
  const StarredReposLDS();

  Future<Page<GithubRepoDto>?> get({
    required int page,
  });

  Future<void> set({
    required int page,
    required Page<GithubRepoDto> starredReposPage,
  });
}
