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
        super(
          const StarredReposState.loaded(
            currentPage: 0,
            repos: [],
            canLoadMore: true,
          ),
        );

  final StarredReposRepo _starredReposRepo;

  Future<void> load() async {
    final canLoadMore = state.map(
      loading: (_) => false,
      loaded: (s) => s.canLoadMore,
    );
    if (!canLoadMore) return;

    state = StarredReposState.loading(
      currentPage: state.currentPage,
      repos: state.repos,
    );

    final newStarredReposPage = await _starredReposRepo.getStarredReposPage(
      pageNumber: state.currentPage + 1,
      pageLength: pageLength,
    );

    final resultingRepos = [
      ...state.repos,
      ...newStarredReposPage.data.elements,
    ];

    state = StarredReposState.loaded(
      currentPage: state.currentPage + 1,
      repos: resultingRepos,
      canLoadMore: newStarredReposPage.data.elements.isNotEmpty,
      warning: newStarredReposPage.when(
        (_) => null,
        withWarning: (_, w) => w,
      ),
    );
  }

  Future<void> reload() async {
    state = const StarredReposState.loaded(
      currentPage: 0,
      repos: [],
      canLoadMore: true,
    );
    await load();
  }
}
