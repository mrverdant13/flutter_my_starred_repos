import 'package:bloc/bloc.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/facades/starred_repos_repo/interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:starred_repos/starred_repos.dart';

part 'cubit.freezed.dart';
part 'state.dart';

/// {@template StarredReposCubit}
/// A cubit that manages starred repos.
/// {@endtemplate}
class StarredReposCubit extends Cubit<StarredReposState> {
  /// Creates an [StarredReposCubit].
  ///
  /// {@macro StarredReposCubit}
  ///
  /// It uses a [starredReposRepo] to perform actions on GitHub starred
  /// repositories and it automatically start loading the first group of starred
  /// repositories if [autoLoad] indicates so.
  StarredReposCubit({
    required StarredReposRepo starredReposRepo,
  })  : _starredReposRepo = starredReposRepo,
        lastCheckedPage = 0,
        lastAvailblePage = 1,
        super(
          const StarredReposState.loaded(
            repos: KtList.empty(),
            canLoadMore: true,
          ),
        );

  /// The facade that actually performs actions on starred repos.
  final StarredReposRepo _starredReposRepo;

  /// The last retrieved page of starred repositories.
  @visibleForTesting
  int lastCheckedPage;

  /// The number of the last available page of starred repositories.
  @visibleForTesting
  int lastAvailblePage;

  /// The flag that indicates whether there are more starred repositories to
  /// retrieve or not.
  bool get _canLoadMore => lastAvailblePage > lastCheckedPage;

  /// The flag that indicates whether more starred repositories are being
  /// loaded.
  bool get _isLoading => state is _StarredReposStateLoading;

  /// Loads starred GitHub repositories.
  Future<void> load() async {
    if (_isLoading || !_canLoadMore) return;

    emit(
      StarredReposState.loading(
        repos: state.repos,
      ),
    );

    final cacheableStarredReposPage =
        await _starredReposRepo.getStarredReposPage(
      page: lastCheckedPage + 1,
    );

    lastCheckedPage++;
    lastAvailblePage = cacheableStarredReposPage.data.lastPage;

    final resultingRepos = state.repos
        .plus(cacheableStarredReposPage.data.elements.kt)
        .distinctBy((repo) => repo.urlPath);

    emit(
      StarredReposState.loaded(
        canLoadMore: _canLoadMore,
        repos: resultingRepos,
        warning: cacheableStarredReposPage.when(
          (_) => null,
          withWarning: (_, w) => w,
        ),
      ),
    );
  }

  /// Reloads all starred GitHub repositories.
  Future<void> reload() async {
    lastCheckedPage = 0;
    lastAvailblePage = 1;
    emit(
      const StarredReposState.loaded(
        repos: KtList.empty(),
        canLoadMore: true,
      ),
    );
    await load();
  }
}
