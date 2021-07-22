import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

import '../../domain/repo.dart';
import '../../infrastructure/facades/starred_repos_repo/interface.dart';

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
        _starredRepos = [],
        lastCheckedPage = 0,
        lastAvailblePage = 1,
        super(
          const StarredReposState.loaded(),
        );

  /// The facade that actually performs actions on starred repos.
  final StarredReposRepo _starredReposRepo;

  /// The cached starred GitHub repositories.
  final List<GithubRepo> _starredRepos;

  /// The found starred GitHub repositories.
  KtList<GithubRepo> get starredRepos =>
      _starredRepos.toImmutableList().distinctBy(
            (repo) => repo.id,
          );

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
  bool get isLoading => state is _StarredReposStateLoading;

  /// Loads starred GitHub repositories.
  Future<void> load() async {
    if (isLoading || !_canLoadMore) return;

    emit(const StarredReposState.loading());

    final cacheableStarredReposPage =
        await _starredReposRepo.getStarredReposPage(
      page: lastCheckedPage + 1,
    );
    lastCheckedPage++;
    lastAvailblePage = cacheableStarredReposPage.data.lastPage;
    _starredRepos.addAll(cacheableStarredReposPage.data.elements);

    if (cacheableStarredReposPage.hasWarning) {
      emit(
        StarredReposState.failure(
          cacheableStarredReposPage.warning!.when(
            offline: () => const StarredReposFailure.offline(),
          ),
        ),
      );
    }

    emit(const StarredReposState.loaded());
  }

  /// Reloads all starred GitHub repositories.
  Future<void> reload() async {
    lastCheckedPage = 0;
    lastAvailblePage = 1;
    _starredRepos.clear();
    await load();
  }
}
