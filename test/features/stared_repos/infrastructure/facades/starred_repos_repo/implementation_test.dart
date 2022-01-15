import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/stared_repos_rds/interface.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/starred_repos_lds/interface.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/facades/starred_repos_repo/implementation.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/facades/starred_repos_repo/interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/starred_repos.dart';
import 'package:test/test.dart';

class MockStarredReposRDS extends Mock implements StaredReposRDS {}

class MockStarredReposLDS extends Mock implements StarredReposLDS {}

class FakeReposPage extends Fake implements Page<GithubRepo> {}

void main() {
  // ARRANGE
  setUpAll(
    () {
      registerFallbackValue(FakeReposPage());
    },
  );

  group(
    '''

GIVEN a starred repos repository
├─ THAT uses a starred repos remote data source
├─ AND  uses a starred repos local data source
AND a repos page number''',
    () {
      // ARRANGE
      late MockStarredReposRDS mockStarredReposRDS;
      late MockStarredReposLDS mockStarredReposLDS;
      late StarredReposRepo starredReposRepo;

      const page = 9;
      const pageLength = 7;
      const lastPage = 12;

      final reposPage = Page(
        lastPage: lastPage,
        elements: List.generate(
          pageLength,
          (idx) => GithubRepo(
            owner: User(
              username: 'username $idx',
              avatarUrl: 'avatar url $idx',
            ),
            name: 'repo $idx',
            description: 'description $idx',
            starsCount: idx,
          ),
        ),
      );

      setUp(
        () {
          mockStarredReposRDS = MockStarredReposRDS();
          mockStarredReposLDS = MockStarredReposLDS();
          starredReposRepo = StarredReposRepoImp(
            starredReposRDS: mockStarredReposRDS,
            starredReposLDS: mockStarredReposLDS,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockStarredReposRDS);
          verifyNoMoreInteractions(mockStarredReposLDS);
        },
      );

      test(
        '''

AND no connectivity issues
AND a new version of the repos page in the server
WHEN the starred repos page is requested
THEN a starred repos page data holder should be received, persisted and returned
├─ BY retrieving the repos page with the starred repos remote data source
├─ AND storing the repos page with the starred repos local data source
├─ AND returning its value
│  ├─ THAT dows not include any warning
''',
        () async {
          when(
            () => mockStarredReposRDS.getStaredReposPage(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => reposPage,
          );
          when(
            () => mockStarredReposLDS.set(
              page: any(named: 'page'),
              starredReposPage: any(named: 'starredReposPage'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            page: page,
          );

          // ASSERT
          verify(
            () => mockStarredReposRDS.getStaredReposPage(
              page: page,
            ),
          ).called(1);
          verify(
            () => mockStarredReposLDS.set(
              page: page,
              starredReposPage: reposPage,
            ),
          ).called(1);
          result.when(
            (_reposPage) => expect(_reposPage, reposPage),
            withWarning: (_, __) => fail(
              'Expected: $PayloadWithoutWarning\n'
              'Actual: ${result.runtimeType}',
            ),
          );
        },
      );

      test(
        '''

AND no connectivity issues
AND no modified data in the server
AND a previously stored version of the repos page
WHEN a starred repos page is requested
THEN the persisted repos page should be returned
├─ BY trying to retrieve a new version of the repos page
├─ AND recognizing its unmodified state
├─ AND retrieving its previously stored representation
├─ AND returning its value
│  ├─ THAT does not include any warning
''',
        () async {
          // ARRANGE
          final initialStarredReposPage = reposPage;
          final expectedStarredReposPage = initialStarredReposPage;

          when(
            () => mockStarredReposRDS.getStaredReposPage(
              page: any(named: 'page'),
            ),
          ).thenThrow(
            const GetStaredReposPageException.unmodified(),
          );
          when(
            () => mockStarredReposLDS.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => initialStarredReposPage,
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            page: page,
          );

          // ASSERT
          verify(
            () => mockStarredReposRDS.getStaredReposPage(
              page: page,
            ),
          ).called(1);
          verify(
            () => mockStarredReposLDS.get(
              page: page,
            ),
          ).called(1);
          result.when(
            (reposPage) => expect(reposPage, expectedStarredReposPage),
            withWarning: (_, __) => fail(
              'Expected: $PayloadWithoutWarning\n'
              'Actual: ${result.runtimeType}',
            ),
          );
        },
      );

      test(
        '''

AND no internet connection
AND a previously stored version of the repos page
WHEN a starred repos page is requested
THEN the persisted repos page should be returned
├─ BY trying to retrieve a new version of the repos page
├─ AND recognizing network issues
├─ AND retrieving its previously stored representation
├─ AND returning its value
│  ├─ THAT includes a warning indicating connectivity issues
''',
        () async {
          // ARRANGE
          final initialStarredReposPage = reposPage;
          final expectedStarredReposPage = initialStarredReposPage;

          when(
            () => mockStarredReposRDS.getStaredReposPage(
              page: any(named: 'page'),
            ),
          ).thenThrow(
            const GetStaredReposPageException.offline(),
          );
          when(
            () => mockStarredReposLDS.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => initialStarredReposPage,
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            page: page,
          );

          // ASSERT
          verify(
            () => mockStarredReposRDS.getStaredReposPage(
              page: page,
            ),
          ).called(1);
          verify(
            () => mockStarredReposLDS.get(
              page: page,
            ),
          ).called(1);
          result.when(
            (reposPage) => fail(
              'Expected: $PayloadWithWarning\n'
              'Actual: ${result.runtimeType}',
            ),
            withWarning: (reposPage, warning) {
              expect(reposPage, expectedStarredReposPage);
              expect(warning, const GetStaredReposWarning.offline());
            },
          );
        },
      );

      test(
        '''

AND no internet connection
AND no previously stored version of the repos page
WHEN a starred repos page is requested
THEN an empty repos page should be returned
├─ BY trying to retrieve a new  repos page
├─ AND recognizing network issues
├─ AND trying to retrieve a previously stored representation of the page
├─ AND overwriting the absent page with an empty one
├─ AND returning its value
│  ├─ THAT includes a warning indicating connectivity issues
''',
        () async {
          // ARRANGE
          const page = 9;
          const expectedStarredReposPage = Page<GithubRepo>(
            lastPage: page,
            elements: [],
          );

          when(
            () => mockStarredReposRDS.getStaredReposPage(
              page: any(named: 'page'),
            ),
          ).thenThrow(
            const GetStaredReposPageException.offline(),
          );
          when(
            () => mockStarredReposLDS.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            page: page,
          );

          // ASSERT
          verify(
            () => mockStarredReposRDS.getStaredReposPage(
              page: page,
            ),
          ).called(1);
          verify(
            () => mockStarredReposLDS.get(
              page: page,
            ),
          ).called(1);
          result.when(
            (reposPage) => fail(
              'Expected: $PayloadWithWarning\n'
              'Actual: ${result.runtimeType}',
            ),
            withWarning: (reposPage, warning) {
              expect(reposPage, expectedStarredReposPage);
              expect(warning, const GetStaredReposWarning.offline());
            },
          );
        },
      );
    },
  );
}
