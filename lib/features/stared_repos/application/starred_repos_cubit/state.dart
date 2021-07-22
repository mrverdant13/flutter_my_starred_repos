part of 'cubit.dart';

/// A union of posible starred repos failure types.
@freezed
class StarredReposFailure with _$StarredReposFailure {
  /// A failure that can occur when starred repos are being retrieved.
  ///
  /// [failure] is the actual failure.
  const factory StarredReposFailure.offline() = _StarredReposFailureOffline;
}

/// A union of [StarredReposCubit]'s states.
@freezed
class StarredReposState with _$StarredReposState {
  /// An [StarredReposCubit] state that indicates that an accion is being
  /// performed.
  const factory StarredReposState.loading() = _StarredReposStateLoading;

  /// An [StarredReposCubit] state that indicates that the starred repos
  /// collection has been updated.
  const factory StarredReposState.loaded() = _StarredReposStateLoaded;

  /// A [StarredReposCubit] state that indicates that a failure occurred during
  /// starred repos related processes.
  ///
  /// [failure] is the holder of the actual failure.
  const factory StarredReposState.failure(
    StarredReposFailure failure,
  ) = _StarredReposStateFailure;
}
