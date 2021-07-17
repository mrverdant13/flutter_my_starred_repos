import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:flutter_app_template/features/stared_repos/domain/page.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/data_sources/stared_repos_rds/interface.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/data_sources/stared_repos_rds/rest_implementation.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/github_repo.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class DioOptionsMatcher extends CustomMatcher {
  DioOptionsMatcher({
    required Map<String, dynamic> headers,
    required Map<String, dynamic> extra,
  }) : super(
          'Dio Options with query parameters',
          'Dio Options',
          predicate<Options>(
            (options) => _optionsPredicate(
              options: options,
              headers: headers,
              extra: extra,
            ),
            'has the given query parameters and extra parameters',
          ),
        );

  static bool _optionsPredicate({
    required Options options,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> extra,
  }) {
    final headersMatch = mapEquals(options.headers, headers);
    if (!headersMatch) return false;

    final extraMatch = mapEquals(options.extra, extra);
    if (!extraMatch) return false;

    return true;
  }
}

void main() {
  group(
    '''

GIVEN a starred repos remote data source''',
    () {
      // External dependencies
      late MockDio mockDio;

      // Remote data source
      late StaredReposRDSImp starredReposRDS;

      setUp(
        () {
          mockDio = MockDio();
          starredReposRDS = StaredReposRDSImp(
            dio: mockDio,
          );
        },
      );

      test(
        '''

AND non-last starred repos page
WHEN the users requests for a starred repos page
THEN a starred repos page data holder is returned
      ''',
        () async {
          // ARRANGE
          const page = 3;
          const responseHeadersMap = {
            'Link': [
              '<https://www.github.com/search/repositories?q=repo&page=${page - 1}>; rel="prev", <https://api.github.com/search/repositories?q=repo&page=1>; rel="first", <https://api.github.com/search/repositories?q=repo&page=${page + 1}>; rel="last"'
            ]
          };

          final starredReposJsonList = List.generate(
            StaredReposRDSImp.pageLength,
            (index) => <String, dynamic>{
              'name': 'repo $index',
              'description': 'description $index',
              'stargazers_count': index,
              'owner': {
                'login': 'username $index',
                'avatar_url': 'avatarUrl $index',
              }
            },
          );
          final starredReposPage = Page(
            lastPage: page + 1,
            elements: List.generate(
              StaredReposRDSImp.pageLength,
              (index) => GithubRepoDto(
                name: 'repo $index',
                description: 'description $index',
                starsCount: index,
                owner: UserDto(
                  username: 'username $index',
                  avatarUrl: 'avatarUrl $index',
                ),
              ),
            ),
          );

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
              headers: Headers.fromMap(responseHeadersMap),
            ),
          );

          // ACT
          final result = await starredReposRDS.getStaredReposPage(
            page: page,
          );

          // ASSERT
          expect(result, starredReposPage);
          verify(
            () => mockDio.get(
              StaredReposRDSImp.endpoint,
              queryParameters: any(
                named: 'queryParameters',
                that: equals({
                  'page': page,
                  'per_page': StaredReposRDSImp.pageLength,
                }),
              ),
              options: any(
                named: 'options',
                that: DioOptionsMatcher(
                  headers: {
                    'Accept': 'application/vnd.github.v3+json',
                  },
                  extra: Map.fromEntries([
                    AuthInterceptor.extraEntry,
                  ]),
                ),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND the last starred repos page
WHEN the users requests for a starred repos page
THEN a starred repos page data holder is returned
      ''',
        () async {
          // ARRANGE
          const page = 3;
          const responseHeadersMap = {
            'Link': [
              '<https://www.github.com/search/repositories?q=repo&page=${page - 1}>; rel="prev", <https://api.github.com/search/repositories?q=repo&page=1>; rel="first"'
            ]
          };

          final starredReposJsonList = List.generate(
            StaredReposRDSImp.pageLength,
            (index) => <String, dynamic>{
              'name': 'repo $index',
              'description': 'description $index',
              'stargazers_count': index,
              'owner': {
                'login': 'username $index',
                'avatar_url': 'avatarUrl $index',
              }
            },
          );
          final starredReposPage = Page(
            lastPage: page,
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
              headers: Headers.fromMap(responseHeadersMap),
            ),
          );

          // ACT
          final result = await starredReposRDS.getStaredReposPage(
            page: page,
          );

          // ASSERT
          expect(result, starredReposPage);
          verify(
            () => mockDio.get(
              StaredReposRDSImp.endpoint,
              queryParameters: any(
                named: 'queryParameters',
                that: equals({
                  'page': page,
                  'per_page': StaredReposRDSImp.pageLength,
                }),
              ),
              options: any(
                named: 'options',
                that: DioOptionsMatcher(
                  headers: {
                    'Accept': 'application/vnd.github.v3+json',
                  },
                  extra: Map.fromEntries([
                    AuthInterceptor.extraEntry,
                  ]),
                ),
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND no internet connection
WHEN the user requests for a starred repos page
THEN an exception is thrown
      ''',
        () async {
          // ARRANGE
          const page = 4;
          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioError(
              requestOptions: RequestOptions(
                path: '',
              ),
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
            throwsA(
              const GetStaredReposPageException.offline(),
            ),
          );
          verify(
            () => mockDio.get(
              StaredReposRDSImp.endpoint,
              queryParameters: any(
                named: 'queryParameters',
                that: equals({
                  'page': page,
                  'per_page': StaredReposRDSImp.pageLength,
                }),
              ),
              options: any(
                named: 'options',
                that: DioOptionsMatcher(
                  headers: {
                    'Accept': 'application/vnd.github.v3+json',
                  },
                  extra: Map.fromEntries([
                    AuthInterceptor.extraEntry,
                  ]),
                ),
              ),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockDio);
        },
      );
    },
  );
}
