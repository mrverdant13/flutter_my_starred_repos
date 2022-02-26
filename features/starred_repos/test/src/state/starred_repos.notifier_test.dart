import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/starred_repos.dart';

import '../../helpers/generators.dart';

class MockStarredReposRepo extends Mock implements StarredReposRepo {}

void main() {
  group(
    '''

GIVEN a starred repos notifier
├─ THAT uses a starred repositories repo''',
    () {
      // ARRANGE
      final r = Random();
      late StarredReposRepo starredReposRepo;
      late StarredReposNotifier starredReposNotifier;

      setUp(
        () {
          starredReposRepo = MockStarredReposRepo();
          starredReposNotifier = StarredReposNotifier(
            starredReposRepo: starredReposRepo,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(starredReposRepo);
        },
      );

      test(
        '''

WHEN no interaction
THEN its initial state should be loaded
''',
        () async {
          // ASSERT
          expect(
            starredReposNotifier.debugState,
            const StarredReposState.loaded(
              currentPage: 0,
              repos: [],
              canLoadMore: true,
            ),
          );
        },
      );

      test(
        '''

├─ THAT holds previously loaded repos
AND loading minimal conditions
AND a non-last starred repos page number
AND the length of the pages
WHEN a starred repos page is requested
THEN the load process should be started
├─ BY emitting the loading state
│  ├─ THAT includes the previously loaded repos
├─ AND retrieving a new repos page with the starred repos repository
THEN the loaded starred repos should be updated
├─ AND emitting the loaded state
│  ├─ THAT includes the previously loaded repos
│  ├─ AND includes the newly loaded repos
│  ├─ AND does not include any warning
''',
        () async {
          // ARRANGE
          final loadedPagesNumber = r.nextInt(10);
          final loadedReposNumber = loadedPagesNumber * pageLength;
          final initiallyLoadedStarredRepos = generateStarredRepos(
            reposCount: loadedReposNumber,
            reposOffset: 0,
          );
          final nextPageNumber = loadedPagesNumber + 1;
          final lastPageNumber = nextPageNumber * 3;
          final expectedStarredReposPage = Page(
            lastPage: lastPageNumber,
            elements: generateStarredRepos(
              reposCount: pageLength,
              reposOffset: loadedReposNumber,
            ),
          );

          // ignore: invalid_use_of_protected_member
          starredReposNotifier.state = StarredReposState.loaded(
            currentPage: loadedPagesNumber,
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          );

          when(
            () => starredReposRepo.getStarredReposPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenAnswer(
            (_) async => Payload(expectedStarredReposPage),
          );

          final states = <StarredReposState>[];
          starredReposNotifier.addListener(
            (starredReposState) => states.add(starredReposState),
            fireImmediately: false,
          );

          // ACT
          await starredReposNotifier.load();

          // ASSERT
          expect(
            states,
            [
              StarredReposState.loading(
                currentPage: loadedPagesNumber,
                repos: initiallyLoadedStarredRepos,
              ),
              StarredReposState.loaded(
                currentPage: nextPageNumber,
                repos: [
                  ...initiallyLoadedStarredRepos,
                  ...expectedStarredReposPage.elements,
                ],
                canLoadMore: true,
              ),
            ],
          );
          verify(
            () => starredReposRepo.getStarredReposPage(
              pageNumber: nextPageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          expect(
            starredReposNotifier.debugState.repos.take(loadedReposNumber),
            initiallyLoadedStarredRepos,
          );
          expect(
            starredReposNotifier.debugState.repos.skip(loadedReposNumber),
            expectedStarredReposPage.elements,
          );
        },
      );

      test(
        '''

├─ THAT holds previously loaded repos
AND no loading minimal conditions
AND a non-last starred repos page number
AND the length of the pages
WHEN a starred repos page is requested
THEN the load process should be started
├─ BY emitting the loading state
│  ├─ THAT includes the previously loaded repos
├─ AND trying to retrieve a new repos page with the starred repos repository
THEN the loaded starred repos should be updated including a warning
├─ AND emitting the loaded state
│  ├─ THAT includes the previously loaded repos
│  ├─ AND includes the newly loaded repos
│  ├─ AND includes any warning
''',
        () async {
          // ARRANGE
          final loadedPagesNumber = r.nextInt(10);
          final loadedReposNumber = loadedPagesNumber * pageLength;
          final initiallyLoadedStarredRepos = generateStarredRepos(
            reposCount: loadedReposNumber,
            reposOffset: 0,
          );
          final nextPageNumber = loadedPagesNumber + 1;
          final lastPageNumber = nextPageNumber * 3;
          final expectedStarredReposPage = Page(
            lastPage: lastPageNumber,
            elements: generateStarredRepos(
              reposCount: pageLength,
              reposOffset: loadedReposNumber,
            ),
          );

          // ignore: invalid_use_of_protected_member
          starredReposNotifier.state = StarredReposState.loaded(
            currentPage: loadedPagesNumber,
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          );

          when(
            () => starredReposRepo.getStarredReposPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenAnswer(
            (_) async => Payload.withWarning(
              data: expectedStarredReposPage,
              warning: const GetStaredReposWarning.offline(),
            ),
          );

          final states = <StarredReposState>[];
          starredReposNotifier.addListener(
            (starredReposState) => states.add(starredReposState),
            fireImmediately: false,
          );

          // ACT
          await starredReposNotifier.load();
          expect(
            states,
            [
              StarredReposState.loading(
                currentPage: loadedPagesNumber,
                repos: initiallyLoadedStarredRepos,
              ),
              StarredReposState.loaded(
                currentPage: nextPageNumber,
                repos: [
                  ...initiallyLoadedStarredRepos,
                  ...expectedStarredReposPage.elements,
                ],
                canLoadMore: true,
                warning: const GetStaredReposWarning.offline(),
              ),
            ],
          );
          verify(
            () => starredReposRepo.getStarredReposPage(
              pageNumber: nextPageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          expect(
            starredReposNotifier.debugState.repos.take(loadedReposNumber),
            initiallyLoadedStarredRepos,
          );
          expect(
            starredReposNotifier.debugState.repos.skip(loadedReposNumber),
            expectedStarredReposPage.elements,
          );
        },
      );

      test(
        '''

├─ THAT holds previously loaded repos
AND loading minimal conditions
WHEN the first page of starred repos is requested
THEN the previous state is restarted
├─ BY emitting the loaded state
│  ├─ THAT does not include any repo
THEN the load process should be started
├─ BY emitting the loading state
│  ├─ THAT does not include any repo
├─ AND retrieving the first repos page with the starred repos repository
THEN the loaded starred repos should be updated
├─ AND emitting the loaded state
│  ├─ THAT includes the newly loaded repos
│  ├─ AND does not include any warning
''',
        () async {
          // ASSERT
          final loadedPagesNumber = r.nextInt(10);
          final loadedReposNumber = loadedPagesNumber * pageLength;
          final initiallyLoadedStarredRepos = generateStarredRepos(
            reposCount: loadedReposNumber,
            reposOffset: 0,
          );
          const nextPageNumber = 1;
          const lastPageNumber = nextPageNumber * 3;
          final expectedStarredReposPage = Page(
            lastPage: lastPageNumber,
            elements: generateStarredRepos(
              reposCount: pageLength,
              reposOffset: loadedReposNumber,
            ),
          );

          // ignore: invalid_use_of_protected_member
          starredReposNotifier.state = StarredReposState.loaded(
            currentPage: loadedPagesNumber,
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          );
          when(
            () => starredReposRepo.getStarredReposPage(
              pageNumber: any(named: 'pageNumber'),
              pageLength: any(named: 'pageLength'),
            ),
          ).thenAnswer(
            (_) async => Payload(
              expectedStarredReposPage,
            ),
          );

          final states = <StarredReposState>[];
          starredReposNotifier.addListener(
            (starredReposState) => states.add(starredReposState),
            fireImmediately: false,
          );

          // ACT
          await starredReposNotifier.reload();

          expect(
            states,
            [
              const StarredReposState.loaded(
                currentPage: 0,
                repos: [],
                canLoadMore: true,
              ),
              const StarredReposState.loading(
                currentPage: 0,
                repos: [],
              ),
              StarredReposState.loaded(
                currentPage: nextPageNumber,
                repos: expectedStarredReposPage.elements,
                canLoadMore: true,
              ),
            ],
          );
          verify(
            () => starredReposRepo.getStarredReposPage(
              pageNumber: nextPageNumber,
              pageLength: pageLength,
            ),
          ).called(1);
          expect(
            starredReposNotifier.debugState.repos,
            expectedStarredReposPage.elements,
          );
        },
      );
    },
  );
}
