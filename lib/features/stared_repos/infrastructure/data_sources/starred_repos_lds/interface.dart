import 'package:starred_repos/starred_repos.dart';

abstract class StarredReposLDS {
  const StarredReposLDS();

  Future<Page<GithubRepo>?> get({
    required int page,
  });

  Future<void> set({
    required int page,
    required Page<GithubRepo> starredReposPage,
  });
}
