import 'package:dartz/dartz.dart';
import 'package:flutter_app_template/features/stared_repos/domain/get_stared_repos_failure.dart';
import 'package:flutter_app_template/features/stared_repos/domain/page.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/converters/page.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/converters/repo.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/data_sources/stared_repos_rds/interface.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/github_repo.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/user.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/facades/starred_repos_repo/implementation.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/facades/starred_repos_repo/interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockStarredReposRDS extends Mock implements StaredReposRDS {}

void main() {
  group(
    '''

GIVEN a starred repos repository implementation''',
    () {
      // Remote data sources
      late MockStarredReposRDS mockStarredReposRDS;

      // Facades
      late StarredReposRepo starredReposRepo;

      setUp(
        () {
          mockStarredReposRDS = MockStarredReposRDS();
          starredReposRepo = StarredReposRepoImp(
            starredReposRDS: mockStarredReposRDS,
          );
        },
      );

      test(
        '''

WHEN a starred repos page is requested
THEN a starred repos page data holder is returned
''',
        () async {
          // ARRANGE
          const page = 9;
          const pageLength = 3;
          const lastPage = 12;

          final initialStarredReposDtosPage = Page(
            lastPage: lastPage,
            elements: List.generate(
              pageLength,
              (idx) => GithubRepoDto(
                owner: UserDto(
                  username: 'username $idx',
                  avatarUrl: 'avatar url $idx',
                ),
                name: 'repo $idx',
                description: 'description $idx',
                starsCount: idx,
              ),
            ),
          );

          final expectedStarredReposPage = initialStarredReposDtosPage.map(
            (starredRepoDto) => starredRepoDto.asEntity,
          );

          when(
            () => mockStarredReposRDS.getStaredReposPage(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => initialStarredReposDtosPage,
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            page: page,
          );

          // ASSERT
          result.fold(
            (failure) => fail('Expected: Right\nActual:${failure.runtimeType}'),
            (resultingStarredReposPage) => expect(
              resultingStarredReposPage,
              expectedStarredReposPage,
            ),
          );
          verify(
            () => mockStarredReposRDS.getStaredReposPage(
              page: page,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockStarredReposRDS);
        },
      );

      test(
        '''

AND no internet connection
WHEN a starred repos page is requested
THEN a failure is returned
''',
        () async {
          // ARRANGE
          const page = 9;
          when(
            () => mockStarredReposRDS.getStaredReposPage(
              page: any(named: 'page'),
            ),
          ).thenThrow(
            const GetStaredReposPageException.offline(),
          );

          // ACT
          final result = await starredReposRepo.getStarredReposPage(
            page: page,
          );

          // ASSERT
          expect(
            result,
            const Left(
              GetStaredReposFailure.offline(),
            ),
          );
          verify(
            () => mockStarredReposRDS.getStaredReposPage(
              page: page,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockStarredReposRDS);
        },
      );
    },
  );
}
