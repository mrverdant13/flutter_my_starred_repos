import 'package:flutter_app_template/features/stared_repos/domain/get_starred_repos_warnings.dart';
import 'package:flutter_app_template/features/stared_repos/domain/page.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/converters/page.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/converters/repo.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/data_sources/stared_repos_rds/interface.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/data_sources/starred_repos_lds/interface.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/github_repo.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/user.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/facades/starred_repos_repo/implementation.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/facades/starred_repos_repo/interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockStarredReposRDS extends Mock implements StaredReposRDS {}

class MockStarredReposLDS extends Mock implements StarredReposLDS {}

class FakeReposPage extends Fake implements Page<GithubRepoDto> {}

void main() {
  group(
    '''

GIVEN a starred repos repository implementation''',
    () {
      // Remote data sources
      late MockStarredReposRDS mockStarredReposRDS;
      late MockStarredReposLDS mockStarredReposLDS;

      // Facades
      late StarredReposRepo starredReposRepo;

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
      setUpAll(
        () {
          registerFallbackValue(FakeReposPage());
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
          result.when(
            (reposPage) => expect(reposPage, expectedStarredReposPage),
            withWarning: (_, __) => fail(
              'Expected: Payload\nActual: Payload.withWarning',
            ),
          );
          verify(
            () => mockStarredReposRDS.getStaredReposPage(
              page: page,
            ),
          ).called(1);
          verify(
            () => mockStarredReposLDS.set(
              page: page,
              starredReposPage: initialStarredReposDtosPage,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockStarredReposRDS);
        },
      );

      test(
        '''

AND no modified data in the server
AND previously stored data
WHEN a starred repos page is requested
THEN the data with no warning is returned
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
          ).thenThrow(
            const GetStaredReposPageException.unmodified(),
          );
          when(
            () => mockStarredReposLDS.get(
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
          result.when(
            (reposPage) => expect(reposPage, expectedStarredReposPage),
            withWarning: (_, __) => fail(
              'Expected: Payload\nActual: Payload.withWarning',
            ),
          );
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
          verifyNoMoreInteractions(mockStarredReposRDS);
        },
      );

      test(
        '''

AND no internet connection
AND previously stored data
WHEN a starred repos page is requested
THEN the data with warning is returned
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
          ).thenThrow(
            const GetStaredReposPageException.offline(),
          );
          when(
            () => mockStarredReposLDS.get(
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
          result.when(
            (reposPage) => fail(
              'Expected: Payload\nActual: Payload.withWarning',
            ),
            withWarning: (reposPage, warning) {
              expect(reposPage, expectedStarredReposPage);
              expect(warning, const GetStaredReposWarning.offline());
            },
          );
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
          verifyNoMoreInteractions(mockStarredReposRDS);
        },
      );

      test(
        '''

AND no internet connection
AND no previously stored data
WHEN a starred repos page is requested
THEN the data with no warning is returned
''',
        () async {
          // ARRANGE
          const page = 9;
          const expectedStarredReposPage = Page(
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
          result.when(
            (reposPage) => fail(
              'Expected: Payload\nActual: Payload.withWarning',
            ),
            withWarning: (reposPage, warning) {
              expect(reposPage, expectedStarredReposPage);
              expect(warning, const GetStaredReposWarning.offline());
            },
          );
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
          verifyNoMoreInteractions(mockStarredReposRDS);
        },
      );
    },
  );
}
