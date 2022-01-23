import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starred_repos/src/domain/get_starred_repos_warnings.dart';
import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.repo.dart';

part 'starred_repos.cubit.freezed.dart';
part 'starred_repos.state.dart';

class StarredReposCubit extends Cubit<StarredReposState> {
  StarredReposCubit({
    required StarredReposRepo starredReposRepo,
  })  : _starredReposRepo = starredReposRepo,
        lastCheckedPage = 0,
        lastAvailblePage = 1,
        super(
          const StarredReposState.loaded(
            repos: [],
            canLoadMore: true,
          ),
        );

  final StarredReposRepo _starredReposRepo;

  @visibleForTesting
  int lastCheckedPage;

  @visibleForTesting
  int lastAvailblePage;

  bool get _canLoadMore => lastAvailblePage > lastCheckedPage;

  bool get _isLoading => state is _StarredReposStateLoading;

  Future<void> load() async {
    if (_isLoading || !_canLoadMore) return;

    emit(StarredReposState.loading(repos: state.repos));

    final cacheableStarredReposPage =
        await _starredReposRepo.getStarredReposPage(
      page: lastCheckedPage + 1,
    );

    lastCheckedPage++;
    lastAvailblePage = cacheableStarredReposPage.data.lastPage;

    final resultingRepos = [
      ...state.repos,
      ...cacheableStarredReposPage.data.elements,
    ];

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

  Future<void> reload() async {
    lastCheckedPage = 0;
    lastAvailblePage = 1;
    emit(
      const StarredReposState.loaded(
        repos: [],
        canLoadMore: true,
      ),
    );
    await load();
  }
}
