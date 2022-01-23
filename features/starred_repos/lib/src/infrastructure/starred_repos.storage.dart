import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:starred_repos/starred_repos.dart';

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

  Future<void> set({
    required int page,
    required Page<GithubRepo> starredReposPage,
  }) async {
    final starredReposPageJson = starredReposPage.toJson((r) => r.toJson());
    await store.record(page).put(_db, starredReposPageJson);
  }

  Future<Page<GithubRepo>?> get({
    required int page,
  }) async {
    final starredReposPageJson = await store.record(page).get(_db);
    if (starredReposPageJson == null) return null;
    return ConvertiblePage.fromJson(
      starredReposPageJson,
      (repoJson) => GithubRepo.fromJson(repoJson),
    );
  }
}
