import 'package:dartz/dartz.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/converters/page.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/converters/repo.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/github_repo.dart';

import '../../../domain/get_stared_repos_failure.dart';
import '../../../domain/page.dart';
import '../../../domain/repo.dart';
import '../../data_sources/stared_repos_rds/interface.dart';
import 'interface.dart';

/// A starred GitHub repositories repository implementation.
class StarredReposRepoImp extends StarredReposRepo {
  /// Creates a starred GitHub repositories repository with the given
  /// [starredReposRDS].
  const StarredReposRepoImp({
    required StaredReposRDS starredReposRDS,
  }) : _starredReposRDS = starredReposRDS;

  /// The remota data source to be used to retrieve the starred GitHub
  /// repositories.
  final StaredReposRDS _starredReposRDS;

  @override
  Future<Either<GetStaredReposFailure, Page<GithubRepo>>> getStarredReposPage({
    required int page,
  }) async {
    late final Page<GithubRepoDto> starredReposDtosPage;

    try {
      starredReposDtosPage = await _starredReposRDS.getStaredReposPage(
        page: page,
      );
    } on GetStaredReposPageException catch (e) {
      return Left(
        e.when(
          offline: () => const GetStaredReposFailure.offline(),
        ),
      );
    }

    final starredReposPage = starredReposDtosPage.map(
      (starredRepoDto) => starredRepoDto.asEntity,
    );

    return Right(starredReposPage);
  }
}
