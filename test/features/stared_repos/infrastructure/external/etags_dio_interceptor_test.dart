import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/external/etags_dio_interceptor.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starred_repos/starred_repos.dart';
import 'package:test/test.dart';

import '../../../../helpers/mock_interceptor.dart';

class MockPageEtagsStorage extends Mock implements PageEtagsStorage {}

const etag = 'etag';

void main() {
  group(
    '''

GIVEN an HTTP client
├─ THAT uses an ETags interceptor
│  ├─ THAT uses a pages ETags local data source''',
    () {
      // ARRANGE
      late MockPageEtagsStorage mockPageEtagsStorage;
      late EtagsInterceptor etagsInterceptor;

      const page = 6;
      RequestOptions createRequest({
        required bool includeEtagsExtraData,
        required bool includePageQueryParam,
      }) =>
          // Using a function to avoid mutability-related issues.
          RequestOptions(
            queryParameters: {
              if (includePageQueryParam) 'page': page,
            },
            path: 'some.url',
          );
      Dio createDio({
        required bool includeEtagInResponse,
      }) =>
          Dio()
            ..interceptors.addAll([
              etagsInterceptor,
              MockerInterceptor(
                responseBuilder: includeEtagInResponse
                    ? (options) => Response(
                          requestOptions: options,
                          statusCode: HttpStatus.ok,
                          headers: Headers.fromMap({
                            'ETag': [etag],
                          }),
                        )
                    : null,
              )
            ]);

      setUp(
        () {
          mockPageEtagsStorage = MockPageEtagsStorage();
          etagsInterceptor = EtagsInterceptor(
            pageEtagsStorage: mockPageEtagsStorage,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockPageEtagsStorage);
        },
      );

      test(
        '''

AND a request
├─ THAT uses etags extra data for interception
├─ THAT includes a page as a query parameter
AND a stored ETag for the given page
WHEN the request is sent
THEN the pages ETags interceptor should alter the request
├─ BY retriving the stored ETag from the pages ETags local data source
├─ AND attaching the ETag to the `If-None-Match` header
''',
        () async {
          // ARRANGE
          final dio = createDio(includeEtagInResponse: false);
          when(
            () => mockPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => etag,
          );

          // ACT
          final result = await dio.fetch(
            createRequest(
              includeEtagsExtraData: true,
              includePageQueryParam: true,
            ),
          );

          // ASSERT
          verify(
            () => mockPageEtagsStorage.get(page: page),
          ).called(1);
          expect(
            result.requestOptions.headers['If-None-Match'],
            etag,
          );
        },
      );

      test(
        '''

AND a request
├─ THAT does not use etags extra data for interception
├─ THAT includes a page as a query parameter
AND a stored ETag for the given page
WHEN the request is sent
THEN the pages ETags interceptor should not alter the request
├─ BY not retrieving the stored ETag from the pages ETags local data source
├─ AND not defining the `If-None-Match` header
''',
        () async {
          // ARRANGE
          final dio = createDio(includeEtagInResponse: false);

          // ACT
          final result = await dio.fetch(
            createRequest(
              includeEtagsExtraData: false,
              includePageQueryParam: true,
            ),
          );

          // ASSERT
          verifyZeroInteractions(mockPageEtagsStorage);
          expect(result.requestOptions.headers['If-None-Match'], isNull);
        },
      );

      test(
        '''

AND a request
├─ THAT uses etags extra data for interception
├─ THAT does not include a page as a query parameter
AND a stored ETag for the given page
WHEN the request is sent
THEN the pages ETags interceptor should not alter the request
├─ BY not retrieving the stored ETag from the pages ETags local data source
├─ AND not defining the `If-None-Match` header
''',
        () async {
          // ARRANGE
          final dio = createDio(includeEtagInResponse: false);

          // ACT
          final result = await dio.fetch(
            createRequest(
              includeEtagsExtraData: true,
              includePageQueryParam: false,
            ),
          );

          // ASSERT
          verifyZeroInteractions(mockPageEtagsStorage);
          expect(result.requestOptions.headers['If-None-Match'], isNull);
        },
      );

      test(
        '''

AND a request
├─ THAT uses etags extra data for interception
├─ THAT includes a page as a query parameter
AND no stored ETag for the given page
WHEN the request is sent
THEN the pages ETags interceptor should not alter the request
├─ BY trying to retrieve the absent ETag from the pages ETags local data source
├─ AND not defining the `If-None-Match` header
''',
        () async {
          // ARRANGE
          final dio = createDio(includeEtagInResponse: false);
          when(
            () => mockPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await dio.fetch(
            createRequest(
              includeEtagsExtraData: true,
              includePageQueryParam: true,
            ),
          );

          // ASSERT
          verify(
            () => mockPageEtagsStorage.get(page: page),
          ).called(1);
          expect(
            result.requestOptions.headers['If-None-Match'],
            isNull,
          );
        },
      );

      test(
        '''

AND a request
├─ THAT uses etags extra data for interception
├─ THAT includes a page as a query parameter
AND a server that assigns ETags for pages requests
WHEN the request is sent
THEN the existence of an ETag should be checked
├─ BY using the pages ETags local data source
AND an ETag for the given page should be received and persisted
├─ BY extracting the ETag from the received response
├─ AND storing it in the pages ETags local data source
''',
        () async {
          // ARRANGE
          final dio = createDio(includeEtagInResponse: true);
          final r = Random();
          final storedEtag = r.nextBool() ? null : etag;
          when(
            () => mockPageEtagsStorage.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) => Future.value(storedEtag),
          );
          when(
            () => mockPageEtagsStorage.set(
              page: any(named: 'page'),
              etag: any(named: 'etag'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await dio.fetch(
            createRequest(
              includeEtagsExtraData: true,
              includePageQueryParam: true,
            ),
          );

          // ASSERT
          expect(
            result.headers['ETag'],
            [etag],
          );
          verify(
            () => mockPageEtagsStorage.get(
              page: page,
            ),
          ).called(1);
          verify(
            () => mockPageEtagsStorage.set(
              page: page,
              etag: etag,
            ),
          ).called(1);
        },
      );
    },
  );
}
