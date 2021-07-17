import 'package:dartz/dartz.dart';

import '../../../domain/get_stared_repos_failure.dart';
import '../../../domain/page.dart';
import '../../../domain/repo.dart';

/// A starred GitHub repositories repository.
abstract class StarredReposRepo {
  /// Creates a starred GitHub repositories repository.
  const StarredReposRepo();

  /// Returns the [page]-th page of the available starred GitHub repositories.
  Future<Either<GetStaredReposFailure, Page<GithubRepo>>> getStarredReposPage({
    required int page,
  });
}
