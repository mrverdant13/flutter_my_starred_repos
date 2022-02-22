import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/domain/page.dart';

class StarredReposStorage {
  StarredReposStorage({
    required Database sembastDatabase,
  })  : _db = sembastDatabase,
        store = StoreRef(storeName);

  final Database _db;

  @visibleForTesting
  final StoreRef<int, Map<String, dynamic>> store;

  @visibleForTesting
  static const storeName = 'starred_repos';

  Future<void> setPage({
    required int pageNumber,
    required List<GithubRepo> starredRepos,
  }) async {
    final pageLength = starredRepos.length;
    await _db.transaction<void>(
      (transaction) async {
        await store.delete(
          transaction,
          finder: Finder(
            offset: (pageNumber - 1) * pageLength,
          ),
        );
        await store.addAll(
          transaction,
          starredRepos.map((r) => r.toJson()).toList(),
        );
      },
    );
  }

  Future<Page<GithubRepo>?> getPage({
    required int pageNumber,
    required int pageLength,
  }) async =>
      _db.transaction(
        (transaction) async {
          final reposCount = await store.count(transaction);
          if (reposCount == 0) return null;
          final lastPage = ((reposCount - 1) ~/ pageLength) + 1;
          final foundReposSnapshots = await store.find(
            transaction,
            finder: Finder(
              offset: (pageNumber - 1) * pageLength,
              limit: pageLength,
            ),
          );
          final foundRepos = foundReposSnapshots
              .map((snapshot) => GithubRepo.fromJson(snapshot.value))
              .toList();
          return Page<GithubRepo>(
            lastPage: lastPage,
            elements: foundRepos,
          );
        },
      );
}
