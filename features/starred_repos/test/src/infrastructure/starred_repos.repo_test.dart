import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/starred_repos.dart';

import '../../helpers/generators.dart';

class MockStarredReposApi extends Mock implements StarredReposApi {}

class MockStarredReposStorage extends Mock implements StarredReposStorage {}

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
├─ THAT uses a starred repos API
├─ AND  uses a starred repos storage''',
    () {
      // ARRANGE
      late Random r;
      late StarredReposApi starredReposApi;
      late StarredReposStorage starredReposStorage;
      late StarredReposRepo starredReposRepo;

      setUp(
        () {
          r = Random();
          starredReposApi = MockStarredReposApi();
          starredReposStorage = MockStarredReposStorage();
          starredReposRepo = StarredReposRepo(
            starredReposApi: starredReposApi,
            starredReposStorage: starredReposStorage,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(starredReposApi);
          verifyNoMoreInteractions(starredReposStorage);
        },
      );

      test(
        '''

AND the number of a starred repos page
AND the length of a starred repos page
AND a new version of the repos page in the server
WHEN the starred repos page is requested
THEN a starred repos page should be received, persisted and returned
├─ BY retrieving the repos page with the starred repos API
├─ AND storing the repos page with the starred repos storage
├─ AND returning its value
│  ├─ THAT dows not include any warning
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10);
          final pageLength = r.nextInt(10);
          final reposOffset = pageNumber * pageLength;
          final reposPage = Page(
            lastPage: 2 * pageNumber,
            elements: generateStarredRepos(
              reposCount: pageLength,
              reposOffset: reposOffset,
            ),
          );
          when(
            () => starredReposApi.getStarredReposPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenAnswer(
            (_) async => reposPage,
          );
          when(
            () => starredReposStorage.setPage(
              pageNumber: any(named: 'pageNumber'),
              starredRepos: any(named: 'starredRepos'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          verify(
            () => starredReposApi.getStarredReposPage(
              pageNumber: pageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          verify(
            () => starredReposStorage.setPage(
              pageNumber: pageNumber,
              starredRepos: reposPage.elements,
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

AND the number of a starred repos page
AND the length of a starred repos page
AND no modified data of the starred repos page in the server
AND a previously stored version of the repos page
WHEN a starred repos page is requested
THEN the persisted repos page should be returned
├─ BY trying to retrieve the starred repos page with the starred repos API
├─ AND recognizing its unmodified state
├─ AND retrieving its previously stored representation
├─ AND returning its value
│  ├─ THAT does not include any warning
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10);
          final pageLength = r.nextInt(10);
          final reposOffset = pageNumber * pageLength;
          final reposPage = Page(
            lastPage: pageNumber * (r.nextInt(10) + 1),
            elements: generateStarredRepos(
              reposCount: pageLength,
              reposOffset: reposOffset,
            ),
          );

          when(
            () => starredReposApi.getStarredReposPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenThrow(
            const GetStarredReposPageException.unmodified(),
          );
          when(
            () => starredReposStorage.getPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenAnswer(
            (_) async => reposPage,
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          verify(
            () => starredReposApi.getStarredReposPage(
              pageNumber: pageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          verify(
            () => starredReposStorage.getPage(
              pageNumber: pageNumber,
              pageLength: pageLength,
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

AND the number of a starred repos page
AND the length of a starred repos page
AND no internet connection
AND a previously stored version of the repos page
WHEN a starred repos page is requested
THEN the persisted repos page should be returned
├─ BY trying to retrieve the starred repos page with the starred repos API
├─ AND recognizing network issues
├─ AND retrieving its previously stored representation
├─ AND returning its value
│  ├─ THAT includes a warning indicating connectivity issues
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10);
          final pageLength = r.nextInt(10);
          final reposOffset = pageNumber * pageLength;
          final reposPage = Page(
            lastPage: pageNumber * (r.nextInt(10) + 1),
            elements: generateStarredRepos(
              reposCount: pageLength,
              reposOffset: reposOffset,
            ),
          );

          when(
            () => starredReposApi.getStarredReposPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenThrow(
            const GetStarredReposPageException.offline(),
          );
          when(
            () => starredReposStorage.getPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenAnswer(
            (_) async => reposPage,
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          verify(
            () => starredReposApi.getStarredReposPage(
              pageNumber: pageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          verify(
            () => starredReposStorage.getPage(
              pageNumber: pageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          result.when(
            (reposPage) => fail(
              'Expected: $PayloadWithWarning\n'
              'Actual: ${result.runtimeType}',
            ),
            withWarning: (_reposPage, warning) {
              expect(_reposPage, reposPage);
              expect(warning, const GetStaredReposWarning.offline());
            },
          );
        },
      );

      test(
        '''

AND the number of a starred repos page
AND the length of a starred repos page
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
          final pageNumber = r.nextInt(10);
          final pageLength = r.nextInt(10);
          final reposPage = Page<GithubRepo>(
            lastPage: pageNumber,
            elements: [],
          );

          when(
            () => starredReposApi.getStarredReposPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenThrow(
            const GetStarredReposPageException.offline(),
          );
          when(
            () => starredReposStorage.getPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          verify(
            () => starredReposApi.getStarredReposPage(
              pageNumber: pageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          verify(
            () => starredReposStorage.getPage(
              pageNumber: pageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          result.when(
            (reposPage) => fail(
              'Expected: $PayloadWithWarning\n'
              'Actual: ${result.runtimeType}',
            ),
            withWarning: (_reposPage, warning) {
              expect(_reposPage, reposPage);
              expect(warning, const GetStaredReposWarning.offline());
            },
          );
        },
      );
    },
  );
}
