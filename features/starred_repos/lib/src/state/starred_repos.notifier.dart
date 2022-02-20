import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starred_repos/src/domain/get_starred_repos_warnings.dart';
import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.repo.dart';
import 'package:state_notifier/state_notifier.dart';

part 'starred_repos.notifier.freezed.dart';
part 'starred_repos.state.dart';

@visibleForTesting
const pageLength = 5;

class StarredReposNotifier extends StateNotifier<StarredReposState> {
  StarredReposNotifier({
    required StarredReposRepo starredReposRepo,
  })  : _starredReposRepo = starredReposRepo,
        lastCheckedPage = 0,
        lastAvailablePage = 1,
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
  int lastAvailablePage;

  bool get _canLoadMore => lastAvailablePage > lastCheckedPage;

  bool get _isLoading => state is _StarredReposStateLoading;

  Future<void> load() async {
    if (_isLoading || !_canLoadMore) return;

    state = StarredReposState.loading(repos: state.repos);

    final cacheableStarredReposPage =
        await _starredReposRepo.getStarredReposPage(
      pageNumber: lastCheckedPage + 1,
      pageLength: pageLength,
    );

    lastCheckedPage++;
    lastAvailablePage = cacheableStarredReposPage.data.lastPage;

    final resultingRepos = [
      ...state.repos,
      ...cacheableStarredReposPage.data.elements,
    ];

    state = StarredReposState.loaded(
      canLoadMore: _canLoadMore,
      repos: resultingRepos,
      warning: cacheableStarredReposPage.when(
        (_) => null,
        withWarning: (_, w) => w,
      ),
    );
  }

  Future<void> reload() async {
    lastCheckedPage = 0;
    lastAvailablePage = 1;
    state = const StarredReposState.loaded(
      repos: [],
      canLoadMore: true,
    );
    await load();
  }
}
