import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/domain/page.dart';
import 'package:starred_repos/src/domain/user.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.api.dart';

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
      late StarredReposApi starredReposApi;

      const page = 7;
      final starredReposJsonList = List.generate(
        StarredReposApi.pageLength,
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
      final requestQueryParams = {
        'page': page,
        'per_page': StarredReposApi.pageLength,
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

      Page<GithubRepo> createReposDtosPage({
        required bool isLastPage,
      }) =>
          Page(
            lastPage: isLastPage ? page : page + 1,
            elements: List.generate(
              StarredReposApi.pageLength,
              (index) => GithubRepo(
                owner: User(
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
        return true;
      }

      setUp(
        () {
          mockDio = MockDio();
          starredReposApi = StarredReposApi(dio: mockDio);
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
          final result = await starredReposApi.getStarredReposPage(
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
              StarredReposApi.retrieveEndpoint,
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
          final result = await starredReposApi.getStarredReposPage(
            page: page,
          );

          // ASSERT
          expect(result, lastStarredReposPage);
          expect(lastStarredReposPage.lastPage, page);
          verify(
            () => mockDio.get(
              StarredReposApi.retrieveEndpoint,
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
          Future<void> action() async => starredReposApi.getStarredReposPage(
                page: page,
              );

          // ASSERT
          expect(
            action,
            throwsA(const GetStarredReposPageException.offline()),
          );
          verify(
            () => mockDio.get(
              StarredReposApi.retrieveEndpoint,
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
          Future<void> action() async => starredReposApi.getStarredReposPage(
                page: page,
              );

          // ASSERT
          expect(
            action,
            throwsA(const GetStarredReposPageException.unmodified()),
          );
          verify(
            () => mockDio.get(
              StarredReposApi.retrieveEndpoint,
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
