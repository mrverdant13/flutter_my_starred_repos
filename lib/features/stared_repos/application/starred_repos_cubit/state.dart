part of 'cubit.dart';

/// A union of [StarredReposCubit]'s states.
@freezed
class StarredReposState with _$StarredReposState {
  /// An [StarredReposCubit] state that indicates that an accion is being
  /// performed.
  const factory StarredReposState.loading({
    required KtList<GithubRepo> repos,
  }) = _StarredReposStateLoading;

  /// An [StarredReposCubit] state that indicates that the starred repos
  /// collection has been updated.
  const factory StarredReposState.loaded({
    required KtList<GithubRepo> repos,
    required bool canLoadMore,
    GetStaredReposWarning? warning,
  }) = _StarredReposStateLoaded;
}
