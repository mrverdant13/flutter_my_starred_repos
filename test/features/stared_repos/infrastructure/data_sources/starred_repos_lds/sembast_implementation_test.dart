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

GIVEN an etags local data source''',
    () {
      // External dependencies
      late Database sembastDb;

      // Remote data source
      late StarredReposLDSImp starredReposLDS;

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

AND a starred repos page data
WHEN the page data is sent to be persisted
THEN the page data is stored
      ''',
        () async {
          // ARRANGE
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

          // ACT
          await starredReposLDS.set(
            page: page,
            starredReposPage: pageData,
          );

          // ASSERT
          final storedReposPage =
              await starredReposLDS.store.record(page).get(sembastDb);
          expect(
            storedReposPage,
            pageData.toJson(
              (repoDto) => repoDto.toJson(),
            ),
          );
        },
      );

      test(
        '''

AND a previously persisted starred repos page data
WHEN the starred repos page linked to the page number is requested
THEN the starred repos page data is returned
      ''',
        () async {
          // ARRANGE
          const page = 7;
          const lastPage = 9;
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

          await starredReposLDS.store.record(page).put(
                sembastDb,
                pageData.toJson(
                  (repoPage) => repoPage.toJson(),
                ),
              );

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
