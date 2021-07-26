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

GIVEN a users repo implementation''',
    () {
      // Remote data sources
      late MockUsersRDS mockUsersRDS;

      // Facades
      late UsersRepoImp usersRepo;

      setUp(
        () {
          mockUsersRDS = MockUsersRDS();
          usersRepo = UsersRepoImp(
            usersRDS: mockUsersRDS,
          );
        },
      );

      test(
        '''

WHEN the users list is requested
THEN a collection of users is returned
''',
        () async {
          // ARRANGE
          final usersDtos = [
            const UserDto(id: 1, name: 'User 1', username: 'user1'),
            const UserDto(id: 2, name: 'User 2', username: 'user2'),
            const UserDto(id: 3, name: 'User 3', username: 'user3'),
          ];
          final users = usersDtos.map((userDto) => userDto.asEntity).toList();

          when(
            () => mockUsersRDS.getUsers(),
          ).thenAnswer(
            (_) async => usersDtos,
          );

          // ACT
          final result = await usersRepo.getUsers();

          // ASSERT
          result.fold(
            (failure) => fail('Expected: Right\nActual:${failure.runtimeType}'),
            (resultingUsers) => expect(
              resultingUsers,
              predicate(
                (List resultingUsers) => listEquals(
                  resultingUsers,
                  users,
                ),
              ),
            ),
          );
          verify(
            () => mockUsersRDS.getUsers(),
          ).called(1);
          verifyNoMoreInteractions(mockUsersRDS);
        },
      );

      test(
        '''

AND no internet connection
WHEN the users list is requested
THEN a failure is returned
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
          expect(
            result,
            const Left(
              GetUsersFailure.offline(),
            ),
          );
          verify(
            () => mockUsersRDS.getUsers(),
          ).called(1);
          verifyNoMoreInteractions(mockUsersRDS);
        },
      );
    },
  );
}
