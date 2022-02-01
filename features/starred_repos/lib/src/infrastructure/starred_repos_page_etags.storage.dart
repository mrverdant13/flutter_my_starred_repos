import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';

class StarredReposPageEtagsStorage {
  StarredReposPageEtagsStorage({
    required Database sembastDatabase,
  })  : _db = sembastDatabase,
        store = StoreRef(storeName);

  final Database _db;

  @visibleForTesting
  final StoreRef<int, String> store;

  @visibleForTesting
  static const storeName = 'etags';

  Future<void> set({
    required int page,
    required String etag,
  }) =>
      store.record(page).put(_db, etag);

  Future<String?> get({
    required int page,
  }) =>
      store.record(page).get(_db);
}
