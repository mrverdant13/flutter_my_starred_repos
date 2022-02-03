import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/starred_repos.dart';

import '../../helpers/generators.dart';

class MockStarredReposRepo extends Mock implements StarredReposRepo {}

void main() {
  group(
    '''

GIVEN a starred repos cubit
├─ THAT uses a starred repositories repo''',
    () {
      // ARRANGE
      final r = Random();
      late StarredReposRepo starredReposRepo;
      late StarredReposCubit starredReposCubit;

      setUp(
        () {
          starredReposRepo = MockStarredReposRepo();
          starredReposCubit = StarredReposCubit(
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
            starredReposCubit.state,
            const StarredReposState.loaded(repos: [], canLoadMore: true),
          );
        },
      );

      {
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

        blocTest<StarredReposCubit, StarredReposState>(
          '''

├─ THAT holds previously loaded repos
AND loading minimal conditions
AND a non-last starred repos page number
AND the lenght of the pages
WHEN a starred repos page is requested
THEN the load process should be started
├─ BY emmiting the loading state
│  ├─ THAT includes the previously loaded repos
├─ AND retrieving a new repos page with the starred repos repository
THEN the loaded starred repos should be updated
├─ AND emmiting the loaded state
│  ├─ THAT includes the previously loaded repos
│  ├─ AND includes the newly loaded repos
│  ├─ AND does not include any warning
''',
          seed: () => StarredReposState.loaded(
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          ),
          build: () {
            starredReposCubit.lastCheckedPage = loadedPagesNumber;
            starredReposCubit.lastAvailblePage = lastPageNumber;
            when(
              () => starredReposRepo.getStarredReposPage(
                pageNumber: any(named: 'pageNumber'),
                pageLength: any(named: 'pageLength'),
              ),
            ).thenAnswer(
              (_) async => Payload(expectedStarredReposPage),
            );
            return starredReposCubit;
          },
          act: (cubit) => cubit.load(),
          expect: () => [
            StarredReposState.loading(
              repos: initiallyLoadedStarredRepos,
            ),
            StarredReposState.loaded(
              repos: [
                ...initiallyLoadedStarredRepos,
                ...expectedStarredReposPage.elements,
              ],
              canLoadMore: true,
            ),
          ],
          verify: (bloc) {
            verify(
              () => starredReposRepo.getStarredReposPage(
                pageNumber: nextPageNumber,
                pageLength: pageLength,
              ),
            ).called(1);
            expect(
              bloc.state.repos.take(loadedReposNumber),
              initiallyLoadedStarredRepos,
            );
            expect(
              bloc.state.repos.skip(loadedReposNumber),
              expectedStarredReposPage.elements,
            );
            expect(bloc.lastCheckedPage, nextPageNumber);
            expect(bloc.lastAvailblePage, lastPageNumber);
          },
        );
      }

      {
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

        blocTest<StarredReposCubit, StarredReposState>(
          '''

├─ THAT holds previously loaded repos
AND no loading minimal conditions
AND a non-last starred repos page number
AND the lenght of the pages
WHEN a starred repos page is requested
THEN the load process should be started
├─ BY emmiting the loading state
│  ├─ THAT includes the previously loaded repos
├─ AND trying to retrieve a new repos page with the starred repos repository
THEN the loaded starred repos should be updated including a warning
├─ AND emmiting the loaded state
│  ├─ THAT includes the previously loaded repos
│  ├─ AND includes the newly loaded repos
│  ├─ AND includes any warning
''',
          seed: () => StarredReposState.loaded(
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          ),
          build: () {
            starredReposCubit.lastCheckedPage = loadedPagesNumber;
            starredReposCubit.lastAvailblePage = lastPageNumber;
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
            return starredReposCubit;
          },
          act: (cubit) => cubit.load(),
          expect: () => [
            StarredReposState.loading(
              repos: initiallyLoadedStarredRepos,
            ),
            StarredReposState.loaded(
              repos: [
                ...initiallyLoadedStarredRepos,
                ...expectedStarredReposPage.elements,
              ],
              canLoadMore: true,
              warning: const GetStaredReposWarning.offline(),
            ),
          ],
          verify: (bloc) {
            verify(
              () => starredReposRepo.getStarredReposPage(
                pageNumber: nextPageNumber,
                pageLength: pageLength,
              ),
            ).called(1);
            expect(
              bloc.state.repos.take(loadedReposNumber),
              initiallyLoadedStarredRepos,
            );
            expect(
              bloc.state.repos.skip(loadedReposNumber),
              expectedStarredReposPage.elements,
            );
            expect(bloc.lastCheckedPage, nextPageNumber);
            expect(bloc.lastAvailblePage, lastPageNumber);
          },
        );
      }

      {
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

        blocTest<StarredReposCubit, StarredReposState>(
          '''

├─ THAT holds previously loaded repos
AND loading minimal conditions
WHEN the first page of starred repos is requested
THEN the previous state is restarted
├─ BY emmiting the loaded state
│  ├─ THAT does not include any repo
THEN the load process should be started
├─ BY emmiting the loading state
│  ├─ THAT does not include any repo
├─ AND retrieving the first repos page with the starred repos repository
THEN the loaded starred repos should be updated
├─ AND emmiting the loaded state
│  ├─ THAT includes the newly loaded repos
│  ├─ AND does not include any warning
''',
          seed: () => StarredReposState.loaded(
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          ),
          build: () {
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
            return starredReposCubit;
          },
          act: (cubit) => cubit.reload(),
          expect: () => [
            const StarredReposState.loaded(
              repos: [],
              canLoadMore: true,
            ),
            const StarredReposState.loading(
              repos: [],
            ),
            StarredReposState.loaded(
              repos: expectedStarredReposPage.elements,
              canLoadMore: true,
            ),
          ],
          verify: (bloc) {
            verify(
              () => starredReposRepo.getStarredReposPage(
                pageNumber: nextPageNumber,
                pageLength: pageLength,
              ),
            ).called(1);
            expect(
              bloc.state.repos,
              expectedStarredReposPage.elements,
            );
          },
        );
      }
    },
  );
}
