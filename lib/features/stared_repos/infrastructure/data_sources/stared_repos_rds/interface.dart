import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starred_repos/starred_repos.dart';

part 'interface.freezed.dart';

/// A data source to interact with stared repos hosted in GitHub.
abstract class StaredReposRDS {
  // TODO: Add const constructor.
  // Creates a stared repositories remote data source.
  // const StaredReposRDS();

  /// Retrieves a [Page] of starred [GithubRepoDto]s by the [page] they belong
  /// to.
  ///
  /// Throws a [GetStaredReposPageException.offline] exception when there is no
  /// Internet connection.
  ///
  /// Throws a [GetStaredReposPageException.unmodified] exception when there is no
  /// changes in data compared to the previously fetched version.
  Future<Page<GithubRepo>> getStaredReposPage({
    required int page,
  });
}

/// A union of exceptions that may be thrown when retrieving a page of GitHub
/// stared repositories.
@freezed
class GetStaredReposPageException with _$GetStaredReposPageException {
  const GetStaredReposPageException._();

  /// An exception thrown when there is no Internet connection.
  const factory GetStaredReposPageException.offline() =
      _GetStaredReposPageExceptionOffline;

  /// An exception thrown when the data has not been modified compared to the
  /// previously fetched one.
  const factory GetStaredReposPageException.unmodified() =
      _GetStaredReposPageExceptionUnmodified;

  // bool get isOffline => this is _GetStaredReposPageExceptionOffline
}
