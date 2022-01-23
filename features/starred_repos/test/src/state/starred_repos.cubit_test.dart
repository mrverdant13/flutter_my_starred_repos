import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/starred_repos.dart';

class MockStarredReposRepo extends Mock implements StarredReposRepo {}

void main() {
  group(
    '''

GIVEN a starred repos cubit
├─ THAT uses a starred repositories repo''',
    () {
      // ARRANGE
      late MockStarredReposRepo mockStarredReposRepo;
      late StarredReposCubit starredReposCubit;

      setUp(
        () {
          mockStarredReposRepo = MockStarredReposRepo();
          starredReposCubit = StarredReposCubit(
            starredReposRepo: mockStarredReposRepo,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockStarredReposRepo);
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
            const StarredReposState.loaded(
              repos: [],
              canLoadMore: true,
            ),
          );
        },
      );

      {
        const page = 5;
        const pageLength = 8;
        final initiallyLoadedStarredRepos = List.generate(
          pageLength,
          (index) => GithubRepo(
            owner: User(
              username: 'username $index',
              avatarUrl: 'avatarUrl $index',
            ),
            name: 'repo $index',
            description: 'description $index',
            starsCount: index,
          ),
        );
        final starredRepos = List.generate(
          pageLength,
          (index) => GithubRepo(
            owner: User(
              username: 'username ${index + pageLength}',
              avatarUrl: 'avatarUrl ${index + pageLength}',
            ),
            name: 'repo ${index + pageLength}',
            description: 'description ${index + pageLength}',
            starsCount: index + pageLength,
          ),
        );
        const expectedLastPage = page + 1;
        final expectedResultingPage = Page(
          lastPage: expectedLastPage,
          elements: starredRepos,
        );

        blocTest<StarredReposCubit, StarredReposState>(
          '''

├─ THAT holds previously loaded repos
AND loading minimal conditions
AND a non-last starred repos page
WHEN a starred repos page is requested
THEN the load process should be started
├─ BY emmiting the loading state
│  ├─ THAT includes the previously loaded repos
├─ AND retrieving a new repos page with the starred repos repository
THEN the loaded starred repos should be updated
├─ AND emmiting the loaded state
│  ├─ THAT includes the previously loaded repos
│  ├─ THAT includes the newly loaded repos
│  ├─ AND does not include any warning
''',
          seed: () => StarredReposState.loaded(
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          ),
          build: () {
            starredReposCubit.lastCheckedPage = page - 1;
            starredReposCubit.lastAvailblePage = page + 1;
            when(
              () => mockStarredReposRepo.getStarredReposPage(
                page: any(named: 'page'),
              ),
            ).thenAnswer(
              (_) async => Payload(
                expectedResultingPage,
              ),
            );
            return starredReposCubit;
          },
          act: (cubit) {
            cubit.load();
          },
          expect: () => [
            StarredReposState.loading(
              repos: initiallyLoadedStarredRepos,
            ),
            StarredReposState.loaded(
              repos: [
                ...initiallyLoadedStarredRepos,
                ...starredRepos,
              ],
              canLoadMore: true,
            ),
          ],
          verify: (bloc) {
            verify(
              () => mockStarredReposRepo.getStarredReposPage(
                page: page,
              ),
            ).called(1);
            expect(
              bloc.state.repos.take(pageLength),
              initiallyLoadedStarredRepos,
            );
            expect(
              bloc.state.repos.skip(initiallyLoadedStarredRepos.length),
              starredRepos,
            );
          },
        );

        blocTest<StarredReposCubit, StarredReposState>(
          '''

├─ THAT holds previously loaded repos
AND no loading minimal conditions
AND a starred repos page
WHEN a starred repos page is requested
THEN the load process should be started
├─ BY emitting the loading state
│  ├─ THAT includes the previously loaded repos
├─ AND trying to retrieve a new repos page with the starred repos repository
THEN the loaded starred repos should be updated including a warning
├─ BY emmiting the loaded state
│  ├─ THAT includes the previously loaded repos
│  ├─ THAT includes the newly loaded repos
│  ├─ AND  includes the loading issue as warning
''',
          seed: () => StarredReposState.loaded(
            repos: initiallyLoadedStarredRepos,
            canLoadMore: true,
          ),
          build: () {
            starredReposCubit.lastCheckedPage = page - 1;
            starredReposCubit.lastAvailblePage = page + 1;
            when(
              () => mockStarredReposRepo.getStarredReposPage(
                page: any(named: 'page'),
              ),
            ).thenAnswer(
              (_) async => Payload.withWarning(
                data: expectedResultingPage,
                warning: const GetStaredReposWarning.offline(),
              ),
            );

            return starredReposCubit;
          },
          act: (cubit) {
            cubit.load();
          },
          expect: () => [
            StarredReposState.loading(repos: initiallyLoadedStarredRepos),
            StarredReposState.loaded(
              repos: [
                ...initiallyLoadedStarredRepos,
                ...starredRepos,
              ],
              canLoadMore: true,
              warning: const GetStaredReposWarning.offline(),
            ),
          ],
          verify: (bloc) {
            verify(
              () => mockStarredReposRepo.getStarredReposPage(
                page: page,
              ),
            ).called(1);
            expect(
              bloc.state.repos.take(pageLength),
              initiallyLoadedStarredRepos,
            );
            expect(
              bloc.state.repos.skip(initiallyLoadedStarredRepos.length),
              starredRepos,
            );
          },
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
              () => mockStarredReposRepo.getStarredReposPage(
                page: any(named: 'page'),
              ),
            ).thenAnswer(
              (_) async => Payload(
                expectedResultingPage,
              ),
            );
            return starredReposCubit;
          },
          act: (cubit) {
            cubit.reload();
          },
          expect: () => [
            const StarredReposState.loaded(
              repos: [],
              canLoadMore: true,
            ),
            const StarredReposState.loading(
              repos: [],
            ),
            StarredReposState.loaded(
              repos: starredRepos,
              canLoadMore: true,
            ),
          ],
          verify: (bloc) {
            verify(
              () => mockStarredReposRepo.getStarredReposPage(
                page: 1,
              ),
            ).called(1);
            expect(
              bloc.state.repos,
              starredRepos,
            );
          },
        );
      }
    },
  );
}
