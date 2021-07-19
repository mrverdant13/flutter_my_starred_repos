import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app_template/features/stared_repos/application/starred_repos_cubit/cubit.dart';
import 'package:flutter_app_template/features/stared_repos/domain/get_stared_repos_failure.dart';
import 'package:flutter_app_template/features/stared_repos/domain/page.dart';
import 'package:flutter_app_template/features/stared_repos/domain/repo.dart';
import 'package:flutter_app_template/features/stared_repos/domain/user.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/facades/starred_repos_repo/interface.dart';
import 'package:kt_dart/collection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockStarredReposRepo extends Mock implements StarredReposRepo {}

void main() {
  group(
    '''

GIVEN a starred repos cubit''',
    () {
      // Facades
      late MockStarredReposRepo mockStarredReposRepo;

      // Cubit
      late StarredReposCubit starredReposCubit;

      setUp(
        () {
          mockStarredReposRepo = MockStarredReposRepo();
          starredReposCubit = StarredReposCubit(
            starredReposRepo: mockStarredReposRepo,
          );
        },
      );

      test(
        '''

WHEN no interaction
THEN its initial state is loaded
''',
        () async {
          // ARRANGE

          // ACT

          // ASSERT
          expect(
            starredReposCubit.state,
            const StarredReposState.loaded(),
          );
        },
      );

      {
        final r = Random();
        const page = 5;
        const pageLength = 8;
        final starredRepos = List.generate(
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
        const expectedLastPage = page + 1;
        final expectedResultingPage = Page(
          lastPage: expectedLastPage,
          elements: starredRepos,
        );
        const possibleGetStarredReposFailures = [
          GetStaredReposFailure.offline(),
        ];
        final expectedGetStarredReposFailure =
            possibleGetStarredReposFailures[r.nextInt(
          possibleGetStarredReposFailures.length,
        )];

        blocTest<StarredReposCubit, StarredReposState>(
          '''

AND loading minimal conditions
AND a non-last starred repos page
WHEN a starred repos page is requested
THEN the load process is started
AND the laod process is finished
AND the resulting starred repos are loaded
      ''',
          build: () {
            starredReposCubit.lastCheckedPage = page - 1;
            starredReposCubit.lastAvailblePage = page + 1;
            when(
              () => mockStarredReposRepo.getStarredReposPage(
                page: any(named: 'page'),
              ),
            ).thenAnswer(
              (_) async => Right(
                expectedResultingPage,
              ),
            );

            return starredReposCubit;
          },
          act: (cubit) {
            cubit.load();
          },
          expect: () => [
            const StarredReposState.loading(),
            const StarredReposState.loaded(),
          ],
          verify: (bloc) {
            verify(
              () => mockStarredReposRepo.getStarredReposPage(
                page: page,
              ),
            ).called(1);
            expect(
              bloc.starredRepos,
              starredRepos.toImmutableList(),
            );
            verifyNoMoreInteractions(mockStarredReposRepo);
          },
        );

        blocTest<StarredReposCubit, StarredReposState>(
          '''

AND no loading minimal conditions
WHEN a starred repos page is requested
THEN the load process is started
THEN a failure state is emited wrapping the actual failure
      ''',
          build: () {
            starredReposCubit.lastCheckedPage = page - 1;
            starredReposCubit.lastAvailblePage = page + 1;
            when(
              () => mockStarredReposRepo.getStarredReposPage(
                page: any(named: 'page'),
              ),
            ).thenAnswer(
              (_) async => Left(expectedGetStarredReposFailure),
            );

            return starredReposCubit;
          },
          act: (cubit) {
            cubit.load();
          },
          expect: () => [
            const StarredReposState.loading(),
            StarredReposState.failure(
              StarredReposFailure.onRetrieve(
                expectedGetStarredReposFailure,
              ),
            ),
          ],
          verify: (bloc) {
            verify(() => mockStarredReposRepo.getStarredReposPage(
                  page: page,
                )).called(1);
            verifyNoMoreInteractions(mockStarredReposRepo);
          },
        );

        blocTest<StarredReposCubit, StarredReposState>(
          '''

AND loading minimal conditions
WHEN the first page of starred repos is requested
THEN the load process is started
AND the laod process is finished
AND the resulting starred repos are loaded
      ''',
          build: () {
            when(
              () => mockStarredReposRepo.getStarredReposPage(
                page: any(named: 'page'),
              ),
            ).thenAnswer(
              (_) async => Right(
                expectedResultingPage,
              ),
            );

            return starredReposCubit;
          },
          act: (cubit) {
            cubit.reload();
          },
          expect: () => [
            const StarredReposState.loading(),
            const StarredReposState.loaded(),
          ],
          verify: (bloc) {
            verify(
              () => mockStarredReposRepo.getStarredReposPage(
                page: 1,
              ),
            ).called(1);
            expect(
              bloc.starredRepos,
              starredRepos.toImmutableList(),
            );
            verifyNoMoreInteractions(mockStarredReposRepo);
          },
        );
      }
    },
  );
}
