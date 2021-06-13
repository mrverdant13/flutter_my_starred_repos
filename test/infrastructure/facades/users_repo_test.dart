import 'package:dartz/dartz.dart';
import 'package:flutter_app_template/domain/use_cases/get_users/use_case.dart';
import 'package:flutter_app_template/infrastructure/data_sources/users/remote/interface.dart';
import 'package:flutter_app_template/infrastructure/facades/users_repo.dart';
import 'package:flutter_app_template/infrastructure/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
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
          final users = {
            const UserR(id: 1, name: 'User 1', username: 'user1'),
            const UserR(id: 2, name: 'User 2', username: 'user2'),
            const UserR(id: 3, name: 'User 3', username: 'user3'),
          };

          when(
            () => mockUsersRDS.getUsers(),
          ).thenAnswer(
            (_) async => users,
          );

          // ACT
          final result = await usersRepo.getUsers();

          // ASSERT
          expect(
            result,
            Right(
              users
                  .map(
                    (userWithUsernamePattern) =>
                        userWithUsernamePattern.asEntity,
                  )
                  .toImmutableSet(),
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
