import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/data_sources/users_rds/interface.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/data_sources/users_rds/rest_implementation.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/dto/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group(
    '''

GIVEN a users remote data source
THAT uses a Dio HTTP client''',
    () {
      // ARRANGE
      late MockDio mockDio;
      late UsersRDSImp usersRDS;

      setUp(
        () {
          mockDio = MockDio();
          usersRDS = UsersRDSImp(
            dio: mockDio,
          );
        },
      );

      test(
        '''

WHEN the users list is requested
THEN the Dio client should be used to retrieve the users
AND a set of user DTOs should be returned
      ''',
        () async {
          // ARRANGE
          const usersCount = 5;
          final usersJson = List.generate(
            usersCount,
            (idx) => {
              'id': idx,
              'name': 'User $idx',
              'username': 'user$idx',
            },
          );
          final users = List.generate(
            usersCount,
            (idx) => UserDto(
              id: idx,
              name: 'User $idx',
              username: 'user$idx',
            ),
          );

          when(
            () => mockDio.get(
              any(),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: usersJson,
            ),
          );

          // ACT
          final result = await usersRDS.getUsers();

          // ASSERT
          verify(
            () => mockDio.get(
              '/users',
            ),
          ).called(1);
          expect(listEquals(result, users), isTrue);
          verifyNoMoreInteractions(mockDio);
        },
      );

      test(
        '''

AND no internet connection
WHEN the users list is requested
THEN the Dio client should be used to retrieve the users
AND an exception should be thrown
''',
        () async {
          // ARRANGE
          when(
            () => mockDio.get(
              any(),
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
          Future<void> action() async => usersRDS.getUsers();

          // ASSERT
          expect(
            action,
            throwsA(
              const GetUsersException.offline(),
            ),
          );
          verify(
            () => mockDio.get(
              '/users',
            ),
          ).called(1);
          verifyNoMoreInteractions(mockDio);
        },
      );
    },
  );
}
