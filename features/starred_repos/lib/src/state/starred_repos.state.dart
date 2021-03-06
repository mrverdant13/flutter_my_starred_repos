part of 'starred_repos.notifier.dart';

@freezed
class StarredReposState with _$StarredReposState {
  // coverage:ignore-start
  const factory StarredReposState.loading({
    required int currentPage,
    required List<GithubRepo> repos,
  }) = _StarredReposStateLoading;
  const factory StarredReposState.loaded({
    required int currentPage,
    required List<GithubRepo> repos,
    required bool canLoadMore,
    GetStaredReposWarning? warning,
  }) = _StarredReposStateLoaded;
  // coverage:ignore-end
}
