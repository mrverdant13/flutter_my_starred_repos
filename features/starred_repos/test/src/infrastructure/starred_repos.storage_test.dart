import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

AND a page number
AND a starred repos page
AND persisted starred repos for that page number and the following ones
AND a persisted last page number
WHEN the page data is sent to be stored with the page number
THEN the page data should be persisted
├─ BY storing the starred repos
├─ AND storing the new last page number
''',
        () async {
          // ARRANGE
          final pageLength = r.nextInt(10) + 1;

          final previouslyStoredLastPage = r.nextInt(100) + 1;
          final previouslyStoredStarredRepos = generateStarredRepos(
            reposCount: previouslyStoredLastPage * pageLength,
            reposOffset: 0,
            prefix: 'previous',
          );
          final previouslyStoredStarredReposJson = previouslyStoredStarredRepos
              .map((repo) => repo.toJson())
              .toList();

          final newPageNumber = r.nextInt(100) + 1;
          final newStarredReposOffset = (newPageNumber - 1) * pageLength;
          final newLastPage = r.nextInt(100) + newPageNumber;
          final newStarredRepos = generateStarredRepos(
            reposCount: pageLength,
            reposOffset: newStarredReposOffset,
            prefix: 'new',
          );
          final newStarredReposPage = Page(
            lastPage: newLastPage,
            elements: newStarredRepos,
          );
          final newStarredReposJson =
              newStarredRepos.map((repo) => repo.toJson()).toList();

          await starredReposStorage.starredReposStore.addAll(
            sembastDb,
            previouslyStoredStarredReposJson,
          );
          final existingLastPage =
              await starredReposStorage.totalPagesRecord.put(
            sembastDb,
            previouslyStoredLastPage,
          );
          final existingStarredReposSnapshots =
              await starredReposStorage.starredReposStore.find(
            sembastDb,
          );
          final existingStarredReposJson =
              existingStarredReposSnapshots.map((snapshot) => snapshot.value);

          expect(
            existingStarredReposJson,
            previouslyStoredStarredReposJson,
          );
          expect(
            existingLastPage,
            previouslyStoredLastPage,
          );

          // ACT
          await starredReposStorage.setPage(
            pageNumber: newPageNumber,
            starredReposPage: newStarredReposPage,
          );

          // ASSERT
          final resultingNewLastPage =
              await starredReposStorage.totalPagesRecord.get(
            sembastDb,
          );
          final resultingNewStarredReposKeys = List.generate(
            pageLength,
            (idx) => idx + newStarredReposOffset + 1, // Keys are 1-based
          );
          final resultingNewStarredReposJson = await starredReposStorage
              .starredReposStore
              .records(resultingNewStarredReposKeys)
              .get(sembastDb);
          expect(resultingNewLastPage, newLastPage);
          expect(resultingNewStarredReposJson, newStarredReposJson);
        },
      );

      test(
        '''

AND a page number
AND a page length
AND no previously persisted starred repos for that page number
AND a previously persisted last page number
WHEN a starred repos page is requested
THEN an empty page should be returned
├─ BY trying to retrieve the persisted starred repos from the database
├─ AND retrieving the stored last page number
├─ AND returning the page with the data
''',
        () async {
          // ARRANGE
          final pageLength = r.nextInt(10) + 1;

          final pageNumber = r.nextInt(10) + 1;
          final storedLastPage = r.nextInt(100) + pageNumber;

          final existingStarredReposCount =
              await starredReposStorage.starredReposStore.count(
            sembastDb,
          );
          final existingLastPage =
              await starredReposStorage.totalPagesRecord.put(
            sembastDb,
            storedLastPage,
          );

          expect(existingStarredReposCount, isZero);
          expect(existingLastPage, storedLastPage);

          // ACT
          final result = await starredReposStorage.getPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          expect(
            result,
            Page<GithubRepo>(lastPage: storedLastPage, elements: []),
          );
        },
      );

      test(
        '''

AND a page number
AND a page length
AND previously persisted starred repos for that page number
AND a previously persisted last page number
WHEN a starred repos page is requested
THEN a starred repos page should be returned
├─ BY retrieving the persisted starred repos from the database
├─ AND retrieving the stored last page number
├─ AND returning the page with the data
''',
        () async {
          // ARRANGE
          final pageLength = r.nextInt(10) + 1;

          final pageNumber = r.nextInt(10) + 1;
          final reposOffset = (pageNumber - 1) * pageLength;

          final previouslyStoredLastPage = r.nextInt(100) + pageNumber;
          final previouslyStoredStarredRepos = generateStarredRepos(
            reposCount: pageLength,
            reposOffset: reposOffset,
          );
          final previouslyStoredStarredReposJson = previouslyStoredStarredRepos
              .map((repo) => repo.toJson())
              .toList();
          final previouslyStoredStarredReposKeys = previouslyStoredStarredRepos
              .mapIndexed((i, _) => i + reposOffset);

          await starredReposStorage.starredReposStore
              .records(previouslyStoredStarredReposKeys)
              .put(
                sembastDb,
                previouslyStoredStarredReposJson,
              );
          final existingStarredReposCount =
              await starredReposStorage.starredReposStore.count(
            sembastDb,
          );
          final existingLastPage =
              await starredReposStorage.totalPagesRecord.put(
            sembastDb,
            previouslyStoredLastPage,
          );

          expect(existingStarredReposCount, isNonZero);
          expect(existingLastPage, previouslyStoredLastPage);

          // ACT
          final result = await starredReposStorage.getPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          expect(
            result,
            Page<GithubRepo>(
              lastPage: previouslyStoredLastPage,
              elements: previouslyStoredStarredRepos,
            ),
          );
        },
      );
    },
  );
}
