import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/src/external/starred_repos_page_etags_interceptor.dart';
import 'package:starred_repos/src/infrastructure/starred_repos.api.dart';
import 'package:starred_repos/src/infrastructure/starred_repos_page_etags.storage.dart';

class MockStarredReposPageEtagsStorage extends Mock
    implements StarredReposPageEtagsStorage {}

void main() {
  final r = Random();

  group(
    '''

GIVEN an HTTP client
├─ THAT uses a starred repos page ETags interceptor
│  ├─ THAT uses a starred repos page ETags storage''',
    () {
      // ARRANGE
      late MockStarredReposPageEtagsStorage starredReposPageEtagsStorage;
      late StarredReposPageEtagsInterceptor starredReposPageEtagsInterceptor;
      late Dio dio;

      setUp(
        () {
          starredReposPageEtagsStorage = MockStarredReposPageEtagsStorage();
          starredReposPageEtagsInterceptor = StarredReposPageEtagsInterceptor(
            starredReposPageEtagsStorage: starredReposPageEtagsStorage,
          );
          dio = Dio()..interceptors.add(starredReposPageEtagsInterceptor);
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(starredReposPageEtagsStorage);
        },
      );

      test(
        '''

AND a request
├─ THAT is not pointing to the starred repos page endpoint
WHEN the request is sent
THEN no ETag should be sent with the request
AND no ETag should be persisted
''',
        () async {
          // ARRANGE
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(requestOptions: options),
                true,
              ),
            ),
          );

          // ACT
          final result = await dio.fetch(RequestOptions(path: 'some.url'));

          // ASSERT
          verifyNever(
            () => starredReposPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          );
          verifyNever(
            () => starredReposPageEtagsStorage.set(
              page: any(named: 'page'),
              etag: any(named: 'etag'),
            ),
          );
          expect(result.requestOptions.headers['If-None-Match'], isNull);
        },
      );

      test(
        '''

AND a starred repos page number
AND a request
├─ THAT is pointing to the starred repos page endpoint
├─ AND does not include the repos page number in its query parameters
WHEN the request is sent
THEN no ETag should be sent with the request
''',
        () async {
          // ARRANGE
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(requestOptions: options),
                true,
              ),
            ),
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
            ),
          );

          // ASSERT
          verifyNever(
            () => starredReposPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          );
          expect(result.requestOptions.headers['If-None-Match'], isNull);
        },
      );

      test(
        '''

AND a starred repos page number
AND a request
├─ THAT is pointing to the starred repos page endpoint
├─ AND includes a non-numberic repos page number query parameter
WHEN the request is sent
THEN no ETag should be sent with the request
''',
        () async {
          // ARRANGE
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(requestOptions: options),
                true,
              ),
            ),
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
              queryParameters: {'page': 'not-a-number'},
            ),
          );

          // ASSERT
          verifyNever(
            () => starredReposPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          );
          expect(result.requestOptions.headers['If-None-Match'], isNull);
        },
      );

      test(
        '''

AND no persisted ETag for the starred repos page number
AND a starred repos page number
AND a request
├─ THAT is pointing to the starred repos page endpoint
├─ AND includes a numberic repos page number query parameter
WHEN the request is sent
THEN no ETag should be sent with the request
''',
        () async {
          // ARRANGE
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(requestOptions: options),
                true,
              ),
            ),
          );
          final starredReposPageNumber = r.nextInt(100);
          when(
            () => starredReposPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => null,
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
              queryParameters: {'page': starredReposPageNumber},
            ),
          );

          // ASSERT
          verify(
            () => starredReposPageEtagsStorage.get(
              page: starredReposPageNumber,
            ),
          ).called(1);
          expect(result.requestOptions.headers['If-None-Match'], isNull);
        },
      );

      test(
        '''

AND a starred repos page number
AND a persisted ETag linked to the starred repos page
AND a request
├─ THAT is pointing to the starred repos page endpoint
├─ AND includes a numberic repos page number query parameter
WHEN the request is sent
THEN the ETag should be sent with the request
├─ BY retrieving the ETag from the starred repos page ETags storage
├─ AND ataching the ETag to the 'If-None-Match' header
''',
        () async {
          // ARRANGE
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(requestOptions: options),
                true,
              ),
            ),
          );
          final starredReposPageNumber = r.nextInt(100);
          final etag = 'etag$starredReposPageNumber';
          when(
            () => starredReposPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) => Future.value(etag),
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
              queryParameters: {
                'page': starredReposPageNumber,
              },
            ),
          );

          // ASSERT
          verify(
            () => starredReposPageEtagsStorage.get(
              page: starredReposPageNumber,
            ),
          ).called(1);
          expect(result.requestOptions.headers['If-None-Match'], etag);
        },
      );

      test(
        '''

AND a request
├─ THAT is pointing to the starred repos page endpoint
AND an expected response
├─ THAT does not include an ETag in its headers
WHEN the request is sent
THEN no ETag should be persisted
''',
        () async {
          // ARRANGE
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(requestOptions: options),
                true,
              ),
            ),
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
            ),
          );

          // ASSERT
          verifyNever(
            () => starredReposPageEtagsStorage.set(
              page: any(named: 'page'),
              etag: any(named: 'etag'),
            ),
          );
          expect(result.headers['ETag'], isNull);
        },
      );

      test(
        '''

AND a request
├─ THAT is pointing to the starred repos page endpoint
├─ AND does not include the repos page number in its query parameters
AND an expected response
├─ THAT includes an ETag in its headers
WHEN the request is sent
THEN no ETag should be persisted
''',
        () async {
          // ARRANGE
          const etag = 'etag';
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(
                  requestOptions: options,
                  headers: Headers.fromMap({
                    'ETag': [etag],
                  }),
                ),
                true,
              ),
            ),
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
            ),
          );

          // ASSERT
          verifyNever(
            () => starredReposPageEtagsStorage.set(
              page: any(named: 'page'),
              etag: any(named: 'etag'),
            ),
          );
          expect(listEquals(result.headers['ETag'], [etag]), isTrue);
        },
      );

      test(
        '''

AND a request
├─ THAT is pointing to the starred repos page endpoint
├─ AND includes a non-numberic repos page number query parameter
AND an expected response
├─ THAT includes an ETag in its headers
WHEN the request is sent
THEN no ETag should be persisted
''',
        () async {
          // ARRANGE
          const etag = 'etag';
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(
                  requestOptions: options,
                  headers: Headers.fromMap({
                    'ETag': [etag],
                  }),
                ),
                true,
              ),
            ),
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
              queryParameters: {'page': 'not-a-number'},
            ),
          );

          // ASSERT
          verifyNever(
            () => starredReposPageEtagsStorage.set(
              page: any(named: 'page'),
              etag: any(named: 'etag'),
            ),
          );
          expect(listEquals(result.headers['ETag'], [etag]), isTrue);
        },
      );

      test(
        '''

AND a request
├─ THAT is pointing to the starred repos page endpoint
├─ AND includes a numberic repos page number query parameter
AND an expected response
├─ THAT includes an ETag in its headers
WHEN the request is sent
THEN the received ETag should be persisted
├─ BY extracting the ETag from the response headers
├─ AND storing the ETag in the starred repos page ETags storage
''',
        () async {
          // ARRANGE
          final starredReposPageNumber = r.nextInt(100);
          final etag = 'etag$starredReposPageNumber';
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) => handler.resolve(
                Response(
                  requestOptions: options,
                  headers: Headers.fromMap({
                    'ETag': [etag],
                  }),
                ),
                true,
              ),
            ),
          );
          when(
            () => starredReposPageEtagsStorage.set(
              page: any(named: 'page'),
              etag: any(named: 'etag'),
            ),
          ).thenAnswer(
            (_) async {},
          );

          // Needed since the `onRequest` handler is called before the
          // `onResponse` handler.
          when(
            () => starredReposPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => null,
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: StarredReposApi.retrieveEndpoint,
              queryParameters: {'page': starredReposPageNumber},
            ),
          );

          // ASSERT
          verify(
            () => starredReposPageEtagsStorage.set(
              page: starredReposPageNumber,
              etag: etag,
            ),
          ).called(1);
          expect(listEquals(result.headers['ETag'], [etag]), isTrue);

          // Needed since the `onRequest` handler is called before the
          // `onResponse` handler.
          verify(
            () => starredReposPageEtagsStorage.get(
              page: starredReposPageNumber,
            ),
          ).called(1);
        },
      );
    },
  );
}
