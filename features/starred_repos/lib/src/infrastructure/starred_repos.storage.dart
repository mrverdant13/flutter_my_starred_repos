import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/domain/page.dart';

class StarredReposStorage {
  StarredReposStorage({
    required Database sembastDatabase,
  })  : _db = sembastDatabase,
        starredReposStore = StoreRef(starredReposStoreName),
        totalPagesStore = StoreRef(totalPagesStoreName);

  final Database _db;

  @visibleForTesting
  final StoreRef<int, Map<String, dynamic>> starredReposStore;

  @visibleForTesting
  final StoreRef<String, int> totalPagesStore;

  @visibleForTesting
  late final RecordRef<String, int> totalPagesRecord =
      totalPagesStore.record(totalPagesRecordKey);

  @visibleForTesting
  static const starredReposStoreName = 'starred_repos';

  @visibleForTesting
  static const totalPagesStoreName = 'total_pages';

  @visibleForTesting
  static const totalPagesRecordKey = 'total_pages';

  /// Persists the [starredReposPage] to the database.
  ///
  /// The [pageNumber] is 1-based.
  Future<void> setPage({
    required int pageNumber,
    required Page<GithubRepo> starredReposPage,
  }) async {
    final starredRepos = starredReposPage.elements;
    final pageLength = starredReposPage.elements.length;
    final offset = (pageNumber - 1) * pageLength;
    final keys = List.generate(
      pageLength,
      (idx) => offset + idx + 1, // Keys are 1-based.
    );
    await _db.transaction<void>(
      (transaction) async {
        await starredReposStore.records(keys).put(
              transaction,
              starredRepos.map((r) => r.toJson()).toList(),
            );
        await totalPagesRecord.put(
          transaction,
          starredReposPage.lastPage,
        );
      },
    );
  }

  /// Retrieves a page of starred repos from the database.
  ///
  /// The [pageNumber] is 1-based.
  Future<Page<GithubRepo>> getPage({
    required int pageNumber,
    required int pageLength,
  }) async {
    final offset = (pageNumber - 1) * pageLength;
    final keys = List.generate(pageLength, (idx) => offset + idx);
    return _db.transaction(
      (transaction) async {
        final rawFoundRepos =
            await starredReposStore.records(keys).get(transaction);
        final foundRepos = rawFoundRepos
            .where((rawRepo) => rawRepo != null)
            .map<GithubRepo>((rawRepo) => GithubRepo.fromJson(rawRepo!))
            .toList();
        final storedStarredReposLastPage = await totalPagesRecord.get(
          transaction,
        );
        final reposCount = await starredReposStore.count(transaction);
        final computedStarredReposLastPage =
            ((reposCount - 1) ~/ pageLength) + 1;
        return Page<GithubRepo>(
          lastPage: storedStarredReposLastPage ?? computedStarredReposLastPage,
          elements: foundRepos,
        );
      },
    );
  }
}
