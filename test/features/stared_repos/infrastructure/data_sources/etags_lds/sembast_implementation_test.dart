import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/etags_lds/sembast_implementation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''

GIVEN an etags local data source''',
    () {
      // External dependencies
      late Database sembastDb;

      // Remote data source
      late PagesEtagsLDSImp pagesEtagsLDS;

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

AND a starred repos page
AND a starred repos page ETag
WHEN the ETag is sent to be persisted
THEN the ETag is stored
      ''',
        () async {
          // ARRANGE
          const page = 3;
          const etag = 'etag';

          // ACT
          await pagesEtagsLDS.set(
            page: page,
            etag: etag,
          );

          // ASSERT
          final storedEtag =
              await pagesEtagsLDS.store.record(page).get(sembastDb);
          expect(storedEtag, etag);
        },
      );

      test(
        '''

AND a starred repos page
AND a previously persisted starred repos page ETag
WHEN the ETag linked to the page is requested
THEN the ETag is returned
      ''',
        () async {
          // ARRANGE
          const page = 3;
          const etag = 'etag';
          await pagesEtagsLDS.store.record(page).put(sembastDb, etag);

          // ACT
          final storedEtag = await pagesEtagsLDS.get(
            page: page,
          );

          // ASSERT
          expect(storedEtag, etag);
        },
      );
    },
  );
}
