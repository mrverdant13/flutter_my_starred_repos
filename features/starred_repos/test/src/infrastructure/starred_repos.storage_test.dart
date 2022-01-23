import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:starred_repos/starred_repos.dart';

void main() {
  group(
    '''

GIVEN an etags local data source
├─ THAT uses a Sembast database''',
    () {
      // ARRANGE
      late Database sembastDb;
      late StarredReposStorage starredReposStorage;

      const page = 3;
      const lastPage = 5;
      const pageData = Page<GithubRepo>(
        lastPage: lastPage,
        elements: <GithubRepo>[
          GithubRepo(
            owner: User(
              username: 'username 1',
              avatarUrl: 'avatar_url_1',
            ),
            name: 'repo 1',
            description: 'description 1',
            starsCount: 1,
          ),
        ],
      );
      final pageDataJson = pageData.toJson(
        (repoDto) => repoDto.toJson(),
      );

      setUp(
        () async {
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

AND no persisted starred repos page data
AND a starred repos page data
WHEN the page data is sent to be stored
THEN the page data should be persisted
├─ BY storing the page data in the Sembast database
''',
        () async {
          // ARRANGE-ASSERT
          Map<String, dynamic>? storedPageDataJson =
              await starredReposStorage.store.record(page).get(sembastDb);
          expect(storedPageDataJson, isNull);

          // ACT
          await starredReposStorage.set(
            page: page,
            starredReposPage: pageData,
          );

          // ASSERT
          storedPageDataJson =
              await starredReposStorage.store.record(page).get(sembastDb);
          expect(storedPageDataJson, pageDataJson);
        },
      );

      test(
        '''

AND a previously persisted starred repos page data
WHEN the starred repos page linked to the page number is requested
THEN the starred repos page data should be returned
├─ BY retrieving the persisted repos page data from the Sembast database
├─ AND returning the page data
      ''',
        () async {
          // ARRANGE-ASSERT
          await starredReposStorage.store.record(page).put(
                sembastDb,
                pageDataJson,
              );
          final storedPageDataJson =
              await starredReposStorage.store.record(page).get(sembastDb);
          expect(storedPageDataJson, pageDataJson);

          // ACT
          final storedPageData = await starredReposStorage.get(
            page: page,
          );

          // ASSERT
          expect(storedPageData, pageData);
        },
      );
    },
  );
}
