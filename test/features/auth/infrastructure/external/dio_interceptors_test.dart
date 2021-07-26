import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/data_sources/creds_storage/interface.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';
import 'package:test/test.dart';

import '../../../../helpers/mock_interceptor.dart';

class MockCredsStorage extends Mock implements CredsStorage {}

void main() {
  group(
    '''

GIVEN an HTTP client with auth extra data
AND an auth interceptor''',
    () {
      const accessToken = 'access_token';
      final extraData = Map.fromEntries([
        AuthInterceptor.extraEntry,
      ]);
      final mockCredsStorage = MockCredsStorage();
      final authInterceptor = AuthInterceptor(
        credsStorage: mockCredsStorage,
      );
      final mockerInterceptor = MockerInterceptor();
      final dio = Dio()
        ..interceptors.addAll([
          authInterceptor,
          mockerInterceptor,
        ]);

      test(
        '''

AND a stored access token
WHEN a request is sent
THEN the token is attached to the `Authorization` header as a bearer one''',
        () async {
          // ARRANGE
          when(
            () => mockCredsStorage.get(),
          ).thenAnswer(
            (_) async => Credentials(accessToken),
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: 'some.url',
              extra: extraData,
            ),
          );

          // ASSERT
          expect(
            result.requestOptions.headers['Authorization'],
            'Bearer $accessToken',
          );
        },
      );

      test(
        '''

AND no stored access token
WHEN a request is sent
THEN the `Authorization` header is not set''',
        () async {
          // ARRANGE
          when(
            () => mockCredsStorage.get(),
          ).thenAnswer(
            (_) async => null,
          );

          // ACT
          final result = await dio.fetch(
            RequestOptions(
              path: 'some.url',
              extra: extraData,
            ),
          );

          // ASSERT
          expect(
            result.requestOptions.headers['Authorization'],
            isNull,
          );
        },
      );
    },
  );
}
