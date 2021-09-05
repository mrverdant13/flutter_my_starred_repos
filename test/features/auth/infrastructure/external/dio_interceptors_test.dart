import 'package:creds_lds/creds_lds.dart';
import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';
import 'package:test/test.dart';

import '../../../../helpers/mock_interceptor.dart';

class MockCredsLDS extends Mock implements CredsLDS {}

void main() {
  group(
    '''

GIVEN an HTTP client
├─ THAT uses an auth interceptor
│  ├─ THAT uses a credentials local data source
AND a request
├─ THAT uses auth extra data for interception''',
    () {
      // ARRANGE
      late MockCredsLDS mockCredsLDS;
      late AuthInterceptor authInterceptor;
      late MockerInterceptor mockerInterceptor;
      late Dio dio;

      final extraData = Map.fromEntries([
        AuthInterceptor.extraEntry,
      ]);
      RequestOptions request() =>
          // Using a function to avoid mutability-related issues.
          RequestOptions(
            path: 'some.url',
            extra: extraData,
          );

      setUp(
        () {
          mockCredsLDS = MockCredsLDS();
          authInterceptor = AuthInterceptor(
            credsLDS: mockCredsLDS,
          );
          mockerInterceptor = MockerInterceptor();
          dio = Dio()
            ..interceptors.addAll([
              authInterceptor,
              mockerInterceptor,
            ]);
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockCredsLDS);
        },
      );

      test(
        '''

AND a stored access token
WHEN the request is sent
THEN the auth interceptor should alter the request
├─ BY retriving an access token with the creds local data source
├─ AND attaching the token to the `Authorization` header as a bearer one
''',
        () async {
          // ARRANGE
          const accessToken = 'access_token';
          when(
            () => mockCredsLDS.get(),
          ).thenAnswer(
            (_) async => Credentials(accessToken),
          );

          // ACT
          final result = await dio.fetch(request());

          // ASSERT
          verify(
            () => mockCredsLDS.get(),
          ).called(1);
          expect(
            result.requestOptions.headers['Authorization'],
            'Bearer $accessToken',
          );
        },
      );

      test(
        '''

AND no stored access token
WHEN the request is sent
THEN the auth interceptor should not alter the request
├─ BY trying to retrive an access token with the creds local data source
├─ AND not defining the `Authorization` header
''',
        () async {
          // ARRANGE
          when(
            () => mockCredsLDS.get(),
          ).thenAnswer(
            (_) async => null,
          );

          // ACT
          final result = await dio.fetch(request());

          // ASSERT
          verify(
            () => mockCredsLDS.get(),
          ).called(1);
          expect(result.requestOptions.headers['Authorization'], isNull);
        },
      );
    },
  );
}
