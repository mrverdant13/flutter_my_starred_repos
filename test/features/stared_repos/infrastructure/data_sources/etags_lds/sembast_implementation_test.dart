import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:starred_repos/starred_repos.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''

GIVEN an etags local data source
├─ THAT uses a Sembast database''',
    () {
      // ARRANGE
      late Database sembastDb;
      late PageEtagsStorage pageEtagsStorage;

      const page = 3;
      const etag = 'etag';

      setUp(
        () async {
          sembastDb = await databaseFactoryMemory.openDatabase(
            sembastInMemoryDatabasePath,
          );

          pageEtagsStorage = PageEtagsStorage(
            sembastDatabase: sembastDb,
          );
        },
      );

      test(
        '''

AND no persisted repos page ETag
AND a starred repos page
AND a starred repos page ETag
WHEN the ETag is sent to be stored
THEN the ETag should be persisted
├─ BY storing the ETag in the Sembast database
      ''',
        () async {
          // ARRANGE-ASSERT
          String? storedEtag =
              await pageEtagsStorage.store.record(page).get(sembastDb);
          expect(storedEtag, isNull);

          // ACT
          await pageEtagsStorage.set(
            page: page,
            etag: etag,
          );

          // ASSERT
          storedEtag = await pageEtagsStorage.store.record(page).get(sembastDb);
          expect(storedEtag, etag);
        },
      );

      test(
        '''

AND a previously persisted starred repos page ETag
AND a starred repos page
WHEN the ETag linked to the page is requested
THEN the ETag should be returned
├─ BY retrieving the persisted ETag from the Sembast database
├─ AND returning the ETag
      ''',
        () async {
          // ARRANGE-ASSERT
          await pageEtagsStorage.store.record(page).put(sembastDb, etag);
          String? storedEtag =
              await pageEtagsStorage.store.record(page).get(sembastDb);
          expect(storedEtag, etag);

          // ACT
          storedEtag = await pageEtagsStorage.get(
            page: page,
          );

          // ASSERT
          expect(storedEtag, etag);
        },
      );
    },
  );
}
