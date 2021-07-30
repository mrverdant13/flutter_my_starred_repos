import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/domain/get_users_failure.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/converters/user.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/data_sources/users_rds/interface.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/dto/user.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/facades/implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersRDS extends Mock implements UsersRDS {}

void main() {
  group(
    '''

GIVEN a users repo implementation
THAT uses a users remote data source''',
    () {
      // ARRANGE
      late MockUsersRDS mockUsersRDS;
      late UsersRepoImp usersRepo;

      setUp(
        () {
          mockUsersRDS = MockUsersRDS();
          usersRepo = UsersRepoImp(
            usersRDS: mockUsersRDS,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockUsersRDS);
        },
      );

      test(
        '''

WHEN the users list is requested
THEN the users remote data source should be used to retrieve the users
AND a collection of users should be returned
''',
        () async {
          // ARRANGE
          final usersDtos = List.generate(
            4,
            (idx) => UserDto(
              id: idx,
              name: 'User $idx',
              username: 'user$idx',
            ),
          );
          final expectedUsers = usersDtos
              .map(
                (userDto) => userDto.asEntity,
              )
              .toList();

          when(
            () => mockUsersRDS.getUsers(),
          ).thenAnswer(
            (_) async => usersDtos,
          );

          // ACT
          final result = await usersRepo.getUsers();

          // ASSERT
          verify(
            () => mockUsersRDS.getUsers(),
          ).called(1);

          result.fold(
            (failure) => fail(
              'Expected: Right\n'
              'Actual:${failure.runtimeType}',
            ),
            (resultingUsers) => expect(
              resultingUsers,
              predicate(
                (List resultingUsers) => listEquals(
                  resultingUsers,
                  expectedUsers,
                ),
              ),
            ),
          );
        },
      );

      test(
        '''

AND no internet connection
WHEN the users list is requested
THEN the users remote data source should be used to retrieve the users
AND a failure should returned
''',
        () async {
          // ARRANGE
          when(
            () => mockUsersRDS.getUsers(),
          ).thenThrow(
            const GetUsersException.offline(),
          );

          // ACT
          final result = await usersRepo.getUsers();

          // ASSERT
          verify(
            () => mockUsersRDS.getUsers(),
          ).called(1);

          expect(
            result,
            const Left(
              GetUsersFailure.offline(),
            ),
          );

          verifyNoMoreInteractions(mockUsersRDS);
        },
      );
    },
  );
}
