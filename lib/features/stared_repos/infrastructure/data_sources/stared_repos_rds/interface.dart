import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/github_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'interface.freezed.dart';

/// A data source to interact with stared repos hosted in GitHub.
abstract class StaredReposRDS {
  /// Creates a stared repositories remote data source.
  const StaredReposRDS();

  /// Retrieves a page of GitHub stared repositories.
  ///
  /// Throws a [GetStaredReposPageException.offline] exception when there is no
  /// Internet connection.
  Future<List<GithubRepoDto>> getStaredReposPage({
    required int page,
  });
}

/// A union of exceptions that may be thrown when retrieving a page of GitHub
/// stared repositories.
@freezed
class GetStaredReposPageException with _$GetStaredReposPageException {
  /// An exception thrown when there is no Internet connection.
  const factory GetStaredReposPageException.offline() =
      _GetStaredReposPageExceptionOffline;
}
