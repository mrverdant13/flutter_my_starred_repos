import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import 'interface.dart';

class PagesEtagsLDSImp extends PagesEtagsLDS {
  PagesEtagsLDSImp({
    required Database sembastDatabase,
  })  : _db = sembastDatabase,
        store = StoreRef(storeName);

  final Database _db;

  @visibleForTesting
  final StoreRef<int, String> store;

  @visibleForTesting
  static const storeName = 'etags';

  @override
  Future<void> set({
    required int page,
    required String etag,
  }) async {
    await store.record(page).put(_db, etag);
  }

  @override
  Future<String?> get({
    required int page,
  }) {
    return store.record(page).get(_db);
  }
}
