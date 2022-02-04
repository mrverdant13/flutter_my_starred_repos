import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast.dart' as db;
import 'package:sembast/sembast_memory.dart';
import 'package:starred_repos/starred_repos.dart';

import '../../helpers/generators.dart';

void main() {
  group(
    '''

GIVEN a starred repos storage
├─ THAT uses a Sembast database''',
    () {
      // ARRANGE
      late Random r;
      late db.Database sembastDb;
      late StarredReposStorage starredReposStorage;

      setUp(
        () async {
          r = Random();
          sembastDb = await databaseFactoryMemory.openDatabase(
            sembastInMemoryDatabasePath,
          );
          starredReposStorage = StarredReposStorage(
            sembastDatabase: sembastDb,
          );
        },
      );

      test(
        '''

AND a collection of starred repos
AND a page number
AND persisted starred repos for that page number and the following ones
WHEN the page data is sent to be stored with the page number
THEN the page data should be persisted
├─ BY removing existing starred repos for that page number and the following ones
├─ AND storing the starred repos
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(93) + 1;
          final pageLength = r.nextInt(14) + 1;
          final reposOffset = pageNumber * pageLength;
          final starredReposToAdd = generateStarredRepos(
            reposCount: pageLength,
            reposOffset: reposOffset,
            prefix: 'new',
          );
          final expectedAddedStarredReposJson = starredReposToAdd.map(
            (r) => r.toJson(),
          );
          final existingStarredReposJson = generateStarredRepos(
            reposCount: 2 * pageNumber * pageLength,
            reposOffset: 0,
            prefix: 'old',
          ).map((r) => r.toJson()).toList();
          await starredReposStorage.store.addAll(
            sembastDb,
            existingStarredReposJson,
          );
          final existingReposCount = await starredReposStorage.store.count(
            sembastDb,
          );
          expect(
            existingReposCount,
            greaterThan(pageNumber * pageLength),
          );

          // ACT
          await starredReposStorage.setPage(
            pageNumber: pageNumber,
            starredRepos: starredReposToAdd,
          );

          // ASSERT
          final storedStarredReposSnapshots =
              await starredReposStorage.store.find(
            sembastDb,
            finder: db.Finder(
              offset: (pageNumber - 1) * pageLength,
              limit: pageLength,
            ),
          );
          final storedStarredReposJson = storedStarredReposSnapshots.map(
            (snapshot) => snapshot.value,
          );
          expect(storedStarredReposJson, expectedAddedStarredReposJson);
        },
      );

      test(
        '''

AND a page number
AND a page length
AND no previously persisted starred repos
WHEN a starred repos page is requested
THEN nothing should be returned
├─ BY trying to retrieve the persisted starred repos from the database
├─ AND not returning anything
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10);
          final pageLength = r.nextInt(10);
          final existingReposCount = await starredReposStorage.store.count(
            sembastDb,
          );
          expect(existingReposCount, isZero);

          // ACT
          final result = await starredReposStorage.getPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          expect(result, isNull);
        },
      );

      test(
        '''

AND a page number
AND a page length
AND previously persisted starred repos for that page number
WHEN a starred repos page is requested
THEN a starred repos page should be returned
├─ BY retrieving the persisted starred repos from the database
├─ AND returning the starred repos page
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10) + 1;
          final pageLength = r.nextInt(10) + 1;
          final reposOffset = pageNumber * pageLength;
          final expectedStarredRepos = generateStarredRepos(
            reposCount: pageLength,
            reposOffset: reposOffset,
          );
          final expectedExistingReposCount = 2 * pageNumber * pageLength;
          final existingStarredReposJson = generateStarredRepos(
            reposCount: expectedExistingReposCount,
            reposOffset: 0,
          ).map((r) => r.toJson()).toList();
          await starredReposStorage.store.addAll(
            sembastDb,
            existingStarredReposJson,
          );
          final existingReposCount = await starredReposStorage.store.count(
            sembastDb,
          );
          expect(existingReposCount, expectedExistingReposCount);

          // ACT
          final result = await starredReposStorage.getPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          expect(
            result,
            Page(
              lastPage: 2 * pageNumber,
              elements: expectedStarredRepos,
            ),
          );
        },
      );
    },
  );
}
