import '../../../domain/get_starred_repos_warnings.dart';
import '../../../domain/page.dart';
import '../../../domain/payload.dart';
import '../../../domain/repo.dart';

/// A starred GitHub repositories repository.
abstract class StarredReposRepo {
  /// Creates a starred GitHub repositories repository.
  const StarredReposRepo(); // coverage:ignore-line

  /// Returns the [page]-th page of the available starred GitHub repositories.
  Future<Payload<Page<GithubRepo>, GetStaredReposWarning>> getStarredReposPage({
    required int page,
  });
}
