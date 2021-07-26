import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/etags_lds/interface.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/external/etags_dio_interceptor.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../helpers/mock_interceptor.dart';

class MockPagesEtagsLDS extends Mock implements PagesEtagsLDS {}

const etag = 'etag';

class FakerEtagedInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.resolve(
      Response(
        requestOptions: options,
        statusCode: HttpStatus.ok,
        headers: Headers.fromMap({
          'ETag': [etag],
        }),
      ),
      true,
    );
  }
}

void main() {
  group(
    '''

GIVEN an HTTP client
AND an page ETags interceptor''',
    () {
      const page = 6;
      final extraData = Map.fromEntries([
        EtagsInterceptor.extraEntry,
      ]);

      late MockPagesEtagsLDS mockPagesEtagsLDS;
      late FakerEtagedInterceptor fakerEtagedInterceptor;

      late EtagsInterceptor etagsInterceptor;

      late Dio dio;

      setUp(
        () {
          mockPagesEtagsLDS = MockPagesEtagsLDS();
          etagsInterceptor = EtagsInterceptor(
            pagesEtagsLDS: mockPagesEtagsLDS,
          );
          fakerEtagedInterceptor = FakerEtagedInterceptor();
        },
      );

      test(
        '''

AND the pages ETags interceptor extra data attached to a request
AND a page attached to the query parameters
AND a stored ETag for the given page
WHEN the request is sent
THEN the ETag is attached to the `If-None-Match` header
''',
        () async {
          // ARRANGE
          dio = Dio()
            ..interceptors.addAll([
              etagsInterceptor,
              MockerInterceptor(),
            ]);
          final requestOptions = RequestOptions(
            extra: extraData,
            queryParameters: {
              'page': page,
            },
            path: 'some.url',
          );

          when(
            () => mockPagesEtagsLDS.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => etag,
          );

          // ACT
          final result = await dio.fetch(
            requestOptions,
          );

          // ASSERT
          expect(
            result.requestOptions.headers['If-None-Match'],
            etag,
          );
        },
      );

      test(
        '''

AND the pages ETags interceptor extra data not attached to a request
AND a page attached to the query parameters
AND a stored ETag for the given page
WHEN the request is sent
THEN the `If-None-Match` header is not set
''',
        () async {
          // ARRANGE
          dio = Dio()
            ..interceptors.addAll([
              etagsInterceptor,
              MockerInterceptor(),
            ]);
          final requestOptions = RequestOptions(
            queryParameters: {
              'page': page,
            },
            path: 'some.url',
          );

          when(
            () => mockPagesEtagsLDS.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) async => etag,
          );

          // ACT
          final result = await dio.fetch(
            requestOptions,
          );

          // ASSERT
          expect(
            result.requestOptions.headers['If-None-Match'],
            isNull,
          );
        },
      );

      test(
        '''

AND the pages ETags interceptor extra data attached to a request
AND no page attached to the query parameters
WHEN the request is sent
THEN the `If-None-Match` header is not set
''',
        () async {
          // ARRANGE
          dio = Dio()
            ..interceptors.addAll([
              etagsInterceptor,
              MockerInterceptor(),
            ]);
          final requestOptions = RequestOptions(
            extra: extraData,
            path: 'some.url',
          );

          // ACT
          final result = await dio.fetch(
            requestOptions,
          );

          // ASSERT
          expect(
            result.requestOptions.headers['If-None-Match'],
            isNull,
          );
        },
      );

      test(
        '''

AND the pages ETags interceptor extra data attached to a request
AND a page attached to the query parameters
AND no stored ETag for the given page
WHEN the request is sent
THEN the `If-None-Match` header is not set
''',
        () async {
          // ARRANGE
          dio = Dio()
            ..interceptors.addAll([
              etagsInterceptor,
              MockerInterceptor(),
            ]);
          final requestOptions = RequestOptions(
            extra: extraData,
            queryParameters: {
              'page': page,
            },
            path: 'some.url',
          );

          when(
            () => mockPagesEtagsLDS.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await dio.fetch(
            requestOptions,
          );

          // ASSERT
          expect(
            result.requestOptions.headers['If-None-Match'],
            isNull,
          );
        },
      );

      test(
        '''

AND the pages ETags interceptor extra data attached to a request
AND a page attached to the query parameters
AND a server that assigns ETags to pages
WHEN the request is sent
THEN an ETag for the given page is received
AND the received ETag is stored
''',
        () async {
          // ARRANGE
          dio = Dio()
            ..interceptors.addAll([
              etagsInterceptor,
              fakerEtagedInterceptor,
            ]);
          final requestOptions = RequestOptions(
            extra: extraData,
            queryParameters: {
              'page': page,
            },
            path: 'some.url',
          );

          when(
            () => mockPagesEtagsLDS.get(
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );
          when(
            () => mockPagesEtagsLDS.set(
              page: any(named: 'page'),
              etag: any(named: 'etag'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          // ACT
          final result = await dio.fetch(
            requestOptions,
          );

          // ASSERT
          expect(
            result.headers['ETag'],
            [etag],
          );
          verify(
            () => mockPagesEtagsLDS.set(
              page: page,
              etag: etag,
            ),
          ).called(1);
        },
      );
    },
  );
}
