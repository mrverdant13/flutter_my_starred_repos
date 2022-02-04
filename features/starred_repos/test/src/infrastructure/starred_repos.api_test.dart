import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/src/domain/page.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.api.dart';

import '../../helpers/generators.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group(
    '''

GIVEN a starred repos API
├─ THAT uses a Dio HTTP client''',
    () {
      // ARRANGE
      late Random r;
      late Dio dio;
      late StarredReposApi starredReposApi;

      setUp(
        () {
          r = Random();
          dio = MockDio();
          starredReposApi = StarredReposApi(dio: dio);
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(dio);
        },
      );

      test(
        '''

AND the number of a non-last page of starred repos
AND a page length
WHEN the starred repos page is requested
THEN a starred repos page should be returned
├─ BY sending the request
├─ AND returning the received repos page
│  ├─ THAT holds a last page number not equal to the requested page
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10) + 1;
          final pageLength = r.nextInt(10) + 1;
          final reposOffset = pageNumber * pageLength;
          final totalPages = pageNumber * 2;
          final nonLastStarredRepos = generateStarredRepos(
            reposCount: pageLength,
            reposOffset: reposOffset,
          );
          final nonLastStarredReposJson =
              nonLastStarredRepos.map((r) => r.toJson()).toList();

          when(
            () => dio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: nonLastStarredReposJson,
              headers: Headers.fromMap({
                'Link': [
                  [
                    if (pageNumber > 1)
                      '<https://www.github.com/search/repositories?q=repo&page=${pageNumber - 1}>; rel="prev"',
                    '<https://api.github.com/search/repositories?q=repo&page=1>; rel="first"',
                    '<https://api.github.com/search/repositories?q=repo&page=$totalPages>; rel="last"',
                  ].join(' ,'),
                ],
              }),
            ),
          );

          // ACT
          final result = await starredReposApi.getStarredReposPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          expect(
            result,
            Page(
              lastPage: totalPages,
              elements: nonLastStarredRepos,
            ),
          );
          expect(result.lastPage, greaterThan(pageNumber));
          verify(
            () => dio.get(
              StarredReposApi.retrieveEndpoint,
              queryParameters: {
                'page': pageNumber,
                'per_page': pageLength,
              },
              options: any(
                named: 'options',
                that: predicate<Options>(
                  (o) =>
                      o.headers?['Accept'] == 'application/vnd.github.v3+json',
                ),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND the number of the last page of starred repos
AND a page length
WHEN the starred repos page is requested
THEN a starred repos page should be returned
├─ BY sending the request
├─ AND returning the received repos page
│  ├─ THAT holds a last page number equal to the requested page
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10) + 1;
          final pageLength = r.nextInt(10) + 1;
          final reposOffset = pageNumber * pageLength;
          final totalPages = pageNumber;
          final nonLastStarredRepos = generateStarredRepos(
            reposCount: pageLength,
            reposOffset: reposOffset,
          );
          final nonLastStarredReposJson =
              nonLastStarredRepos.map((r) => r.toJson()).toList();

          when(
            () => dio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: nonLastStarredReposJson,
              headers: Headers.fromMap({
                'Link': [
                  [
                    if (pageNumber > 1)
                      '<https://www.github.com/search/repositories?q=repo&page=${pageNumber - 1}>; rel="prev"',
                    '<https://api.github.com/search/repositories?q=repo&page=1>; rel="first"',
                    '<https://api.github.com/search/repositories?q=repo&page=$totalPages>; rel="last"',
                  ].join(' ,'),
                ],
              }),
            ),
          );

          // ACT
          final result = await starredReposApi.getStarredReposPage(
            pageNumber: pageNumber,
            pageLength: pageLength,
          );

          // ASSERT
          expect(
            result,
            Page(
              lastPage: totalPages,
              elements: nonLastStarredRepos,
            ),
          );
          expect(result.lastPage, pageNumber);
          verify(
            () => dio.get(
              StarredReposApi.retrieveEndpoint,
              queryParameters: {
                'page': pageNumber,
                'per_page': pageLength,
              },
              options: any(
                named: 'options',
                that: predicate<Options>(
                  (o) =>
                      o.headers?['Accept'] == 'application/vnd.github.v3+json',
                ),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND the number of a starred repos page
AND no Internet connection
WHEN the starred repos page is requested
THEN an exception should be thrown
├─ BY sending the HTTP request
├─ AND throwing an exception indicating connectivity issues
''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10) + 1;
          final pageLength = r.nextInt(10) + 1;
          when(
            () => dio.get(
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
                pageNumber: pageNumber,
                pageLength: pageLength,
              );

          // ASSERT
          expect(
            action,
            throwsA(const GetStarredReposPageException.offline()),
          );
          verify(
            () => dio.get(
              StarredReposApi.retrieveEndpoint,
              queryParameters: {
                'page': pageNumber,
                'per_page': pageLength,
              },
              options: any(
                named: 'options',
                that: predicate<Options>(
                  (o) =>
                      o.headers?['Accept'] == 'application/vnd.github.v3+json',
                ),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND the number of a starred repos page
AND no modifications detected by the server for that page
WHEN the starred repos page is requested
THEN an exception should be thrown
├─ BY sending the HTTP request
├─ AND throwing an exception indicating unmodified status
      ''',
        () async {
          // ARRANGE
          final pageNumber = r.nextInt(10) + 1;
          final pageLength = r.nextInt(10) + 1;
          when(
            () => dio.get(
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
                pageNumber: pageNumber,
                pageLength: pageLength,
              );

          // ASSERT
          expect(
            action,
            throwsA(const GetStarredReposPageException.unmodified()),
          );
          verify(
            () => dio.get(
              StarredReposApi.retrieveEndpoint,
              queryParameters: {
                'page': pageNumber,
                'per_page': pageLength,
              },
              options: any(
                named: 'options',
                that: predicate<Options>(
                  (o) =>
                      o.headers?['Accept'] == 'application/vnd.github.v3+json',
                ),
              ),
            ),
          ).called(1);
        },
      );
    },
  );
}
