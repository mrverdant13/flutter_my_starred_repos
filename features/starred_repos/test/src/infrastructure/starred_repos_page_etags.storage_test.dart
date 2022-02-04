import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:starred_repos/src/infrastructure/starred_repos_page_etags.storage.dart';

void main() {
  final r = Random();

  group(
    '''

GIVEN a starred repos page ETags storage
├─ THAT uses a Sembast database
AND a starred repos page number''',
    () {
      // ARRANGE
      late Database sembastDb;
      late StarredReposPageEtagsStorage starredReposPageEtagsStorage;
      late int starredReposPageNumber;

      setUp(
        () async {
          sembastDb = await databaseFactoryMemory.openDatabase(
            sembastInMemoryDatabasePath,
          );
          starredReposPageEtagsStorage = StarredReposPageEtagsStorage(
            sembastDatabase: sembastDb,
          );
          starredReposPageNumber = r.nextInt(1000);
        },
      );

      test(
        '''

AND a starred repos page ETag
WHEN the ETag is sent to be stored
THEN the ETag should be persisted
├─ BY storing the ETag in the Sembast
''',
        () async {
          // ARRANGE
          const starredReposPageEtag = 'etag';

          // ACT
          await starredReposPageEtagsStorage.set(
            page: starredReposPageNumber,
            etag: starredReposPageEtag,
          );

          // ASSERT
          final storedStarredReposPageEtag = await starredReposPageEtagsStorage
              .store
              .record(starredReposPageNumber)
              .get(sembastDb);
          expect(starredReposPageEtag, storedStarredReposPageEtag);
        },
      );

      test(
        '''

AND a previously persisted starred repos page ETag
AND a starred repos page number
WHEN the ETag linked to the page is requested
THEN the ETag should be returned
├─ BY retrieving the persisted ETag from the Sembast database
├─ AND returning the ETag
''',
        () async {
          // ARRANGE
          const previouslyStoredStarredReposPageEtag = 'etag';
          await starredReposPageEtagsStorage.store
              .record(starredReposPageNumber)
              .put(sembastDb, previouslyStoredStarredReposPageEtag);
          final storedStarredReposPageEtag = await starredReposPageEtagsStorage
              .store
              .record(starredReposPageNumber)
              .get(sembastDb);
          expect(
            storedStarredReposPageEtag,
            previouslyStoredStarredReposPageEtag,
          );

          // ACT
          final result = await starredReposPageEtagsStorage.get(
            page: starredReposPageNumber,
          );

          // ASSERT
          expect(result, previouslyStoredStarredReposPageEtag);
        },
      );
    },
  );
}
