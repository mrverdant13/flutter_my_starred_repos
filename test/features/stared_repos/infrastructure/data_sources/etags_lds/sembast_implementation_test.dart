import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/etags_lds/sembast_implementation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''

GIVEN an etags local data source
├─ THAT uses a Sembast database''',
    () {
      // ARRANGE
      late Database sembastDb;
      late PagesEtagsLDSImp pagesEtagsLDS;

      const page = 3;
      const etag = 'etag';

      setUp(
        () async {
          sembastDb = await databaseFactoryMemory.openDatabase(
            sembastInMemoryDatabasePath,
          );

          pagesEtagsLDS = PagesEtagsLDSImp(
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
              await pagesEtagsLDS.store.record(page).get(sembastDb);
          expect(storedEtag, isNull);

          // ACT
          await pagesEtagsLDS.set(
            page: page,
            etag: etag,
          );

          // ASSERT
          storedEtag = await pagesEtagsLDS.store.record(page).get(sembastDb);
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
          await pagesEtagsLDS.store.record(page).put(sembastDb, etag);
          String? storedEtag =
              await pagesEtagsLDS.store.record(page).get(sembastDb);
          expect(storedEtag, etag);

          // ACT
          storedEtag = await pagesEtagsLDS.get(
            page: page,
          );

          // ASSERT
          expect(storedEtag, etag);
        },
      );
    },
  );
}
