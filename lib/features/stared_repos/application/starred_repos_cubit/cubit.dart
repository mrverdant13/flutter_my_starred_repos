import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

import '../../domain/get_stared_repos_failure.dart';
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
    bool autoLoad = false,
  })  : _starredReposRepo = starredReposRepo,
        _starredRepos = [],
        _lastCheckedPage = 0,
        _lastAvailblePage = 1,
        super(
          const StarredReposState.loaded(),
        ) {
    if (autoLoad) load();
  }

  /// The facade that actually performs actions on starred repos.
  final StarredReposRepo _starredReposRepo;

  /// The cached starred GitHub repositories.
  final List<GithubRepo> _starredRepos;

  /// The found starred GitHub repositories.
  KtList<GithubRepo> get starredRepos => _starredRepos.toImmutableList();

  /// The last retrieved page of starred repositories.
  int _lastCheckedPage;

  /// The number of the last available page of starred repositories.
  int _lastAvailblePage;

  /// The flag that indicates whether there are more starred repositories to
  /// retrieve or not.
  bool get _canLoadMore => _lastAvailblePage > _lastCheckedPage;

  /// The flag that indicates whether more starred repositories are being
  /// loaded.
  bool get isLoading => state is _StarredReposStateLoading;

  /// Loads starred GitHub repositories.
  Future<void> load() async {
    if (isLoading || !_canLoadMore) return;

    emit(const StarredReposState.loading());

    final failureOrStarredReposPage =
        await _starredReposRepo.getStarredReposPage(
      page: _lastCheckedPage + 1,
    );

    emit(
      failureOrStarredReposPage.fold(
        (failure) => StarredReposState.failure(
          StarredReposFailure.onRetrieve(
            failure,
          ),
        ),
        (starredReposPage) {
          _lastCheckedPage++;
          _lastAvailblePage = starredReposPage.lastPage;
          _starredRepos.addAll(starredReposPage.elements);
          return const StarredReposState.loaded();
        },
      ),
    );
  }

  /// Reloads all starred GitHub repositories.
  Future<void> reload() async {
    _lastCheckedPage = 0;
    _lastAvailblePage = 1;
    _starredRepos.clear();
    await load();
  }
}
