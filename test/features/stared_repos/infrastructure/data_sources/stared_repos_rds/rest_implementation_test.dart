import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/domain/page.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/stared_repos_rds/interface.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/stared_repos_rds/rest_implementation.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/dtos/github_repo.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/dtos/user.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/external/etags_dio_interceptor.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group(
    '''

GIVEN a starred repos remote data source
├─ THAT uses a Dio HTTP client
AND an HTTP request
├─ THAT includes a page number as a query parameter
├─ AND  includes a page size as a query parameter
├─ AND  includes the proper `Accept` header to receive a JSON-formatted response
├─ AND  includes auth extra data for interception
├─ AND  includes ETags extra data for interception''',
    () {
      // ARRANGE
      late MockDio mockDio;
      late StaredReposRDSImp starredReposRDS;

      const page = 7;
      final starredReposJsonList = List.generate(
        StaredReposRDSImp.pageLength,
        (index) => <String, dynamic>{
          'name': 'repo $index',
          'description': 'description $index',
          'stargazers_count': index,
          'owner': {
            'login': 'username $index',
            'avatar_url': 'avatarUrl $index',
          },
        },
      );
      final requestExtraData = Map.fromEntries([
        AuthInterceptor.extraEntry,
        EtagsInterceptor.extraEntry,
      ]);
      final requestQueryParams = {
        'page': page,
        'per_page': StaredReposRDSImp.pageLength,
      };
      final requestHeaders = {
        'Accept': 'application/vnd.github.v3+json',
      };

      Headers createResponseHeaders({
        required bool isLastPage,
      }) {
        final linksStr = [
          '<https://www.github.com/search/repositories?q=repo&page=${page - 1}>; rel="prev"',
          '<https://api.github.com/search/repositories?q=repo&page=1>; rel="first"',
          if (!isLastPage)
            '<https://api.github.com/search/repositories?q=repo&page=${page + 1}>; rel="last"',
        ].join(' ,');
        return Headers.fromMap({
          'Link': [linksStr],
        });
      }

      Page<GithubRepoDto> createReposDtosPage({
        required bool isLastPage,
      }) =>
          Page(
            lastPage: isLastPage ? page : page + 1,
            elements: List.generate(
              StaredReposRDSImp.pageLength,
              (index) => GithubRepoDto(
                owner: UserDto(
                  username: 'username $index',
                  avatarUrl: 'avatarUrl $index',
                ),
                name: 'repo $index',
                description: 'description $index',
                starsCount: index,
              ),
            ),
          );

      bool optionsPredicate(Options options) {
        final headersMatch = mapEquals(options.headers, requestHeaders);
        if (!headersMatch) return false;

        final extraMatch = mapEquals(options.extra, requestExtraData);
        if (!extraMatch) return false;

        return true;
      }

      setUp(
        () {
          mockDio = MockDio();
          starredReposRDS = StaredReposRDSImp(
            dio: mockDio,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockDio);
        },
      );

      test(
        '''

AND a non-last starred repos page number
WHEN the starred repos page is requested
THEN a starred repos page data holder should be returned
├─ BY sending the request
├─ AND returning the received repos page
│  ├─ THAT holds a last page number not equal to the requested page
      ''',
        () async {
          // ARRANGE
          final lastStarredReposPage = createReposDtosPage(isLastPage: false);

          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: starredReposJsonList,
              headers: createResponseHeaders(isLastPage: false),
            ),
          );

          // ACT
          final result = await starredReposRDS.getStaredReposPage(
            page: page,
          );

          // ASSERT
          expect(result, lastStarredReposPage);
          expect(
            lastStarredReposPage.lastPage,
            predicate<int>((lastPage) => lastPage > page),
          );
          verify(
            () => mockDio.get(
              StaredReposRDSImp.endpoint,
              queryParameters: requestQueryParams,
              options: any(
                named: 'options',
                that: predicate(optionsPredicate),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND the last starred repos page number
WHEN the starred repos page is requested
THEN a starred repos page data holder should be returned
├─ BY sending the request
├─ AND returning the received repos page
│  ├─ THAT holds a last page number equal to the requested page
      ''',
        () async {
          // ARRANGE
          final lastStarredReposPage = createReposDtosPage(isLastPage: true);

          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: starredReposJsonList,
              headers: createResponseHeaders(isLastPage: true),
            ),
          );

          // ACT
          final result = await starredReposRDS.getStaredReposPage(
            page: page,
          );

          // ASSERT
          expect(result, lastStarredReposPage);
          expect(lastStarredReposPage.lastPage, page);
          verify(
            () => mockDio.get(
              StaredReposRDSImp.endpoint,
              queryParameters: requestQueryParams,
              options: any(
                named: 'options',
                that: predicate(optionsPredicate),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND a repos page number
AND no Internet connection
WHEN the starred repos page is requested
THEN an exception should be thrown
├─ BY sending the HTTP request
├─ AND throwing an exception indicating connectivity issues
''',
        () async {
          // ARRANGE
          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioError(
              requestOptions: RequestOptions(path: ''),
              error: const SocketException(''),
            ),
          );

          // ACT
          Future<void> action() async => starredReposRDS.getStaredReposPage(
                page: page,
              );

          // ASSERT
          expect(
            action,
            throwsA(const GetStaredReposPageException.offline()),
          );
          verify(
            () => mockDio.get(
              StaredReposRDSImp.endpoint,
              queryParameters: requestQueryParams,
              options: any(
                named: 'options',
                that: predicate(optionsPredicate),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND a repos page number
AND no modifications detected by the server
WHEN the starred repos page is requested
THEN an exception should be thrown
├─ BY sending the HTTP request
├─ AND throwing an exception indicating unmodified status
      ''',
        () async {
          // ARRANGE
          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioError(
              requestOptions: RequestOptions(path: ''),
              type: DioErrorType.response,
              response: Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 304,
              ),
            ),
          );

          // ACT
          Future<void> action() async => starredReposRDS.getStaredReposPage(
                page: page,
              );

          // ASSERT
          expect(
            action,
            throwsA(const GetStaredReposPageException.unmodified()),
          );
          verify(
            () => mockDio.get(
              StaredReposRDSImp.endpoint,
              queryParameters: requestQueryParams,
              options: any(
                named: 'options',
                that: predicate(optionsPredicate),
              ),
            ),
          ).called(1);
        },
      );
    },
  );
}
