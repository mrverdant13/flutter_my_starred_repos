import 'package:flutter_my_starred_repos/features/stared_repos/domain/page.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/converters/page.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/starred_repos_lds/sembast_implementation.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/dtos/github_repo.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/dtos/user.dart';
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
      late StarredReposLDSImp starredReposLDS;

      const page = 3;
      const lastPage = 5;
      const pageData = Page<GithubRepoDto>(
        lastPage: lastPage,
        elements: <GithubRepoDto>[
          GithubRepoDto(
            owner: UserDto(
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
          starredReposLDS = StarredReposLDSImp(
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
              await starredReposLDS.store.record(page).get(sembastDb);
          expect(storedPageDataJson, isNull);

          // ACT
          await starredReposLDS.set(
            page: page,
            starredReposPage: pageData,
          );

          // ASSERT
          storedPageDataJson =
              await starredReposLDS.store.record(page).get(sembastDb);
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
          await starredReposLDS.store.record(page).put(
                sembastDb,
                pageDataJson,
              );
          final storedPageDataJson =
              await starredReposLDS.store.record(page).get(sembastDb);
          expect(storedPageDataJson, pageDataJson);

          // ACT
          final storedPageData = await starredReposLDS.get(
            page: page,
          );

          // ASSERT
          expect(storedPageData, pageData);
        },
      );
    },
  );
}
