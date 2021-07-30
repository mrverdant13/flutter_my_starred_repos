import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/application/users_cubit/cubit.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/domain/get_users_failure.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/domain/user.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/facades/interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersRepo extends Mock implements UsersRepo {}

void main() {
  group(
    '''

GIVEN a users cubit
THAT uses a users repo''',
    () {
      // ARRANGE
      late MockUsersRepo mockUsersRepo;
      late UsersCubit usersCubit;

      setUp(
        () {
          mockUsersRepo = MockUsersRepo();
          usersCubit = UsersCubit(
            usersRepo: mockUsersRepo,
          );
        },
      );

      test(
        '''

WHEN no interaction
THEN its initial state should be idle
''',
        () async {
          // ASSERT
          expect(usersCubit.state, const UsersState.idle());
        },
      );

      {
        final users = List.generate(
          8,
          (idx) => User(
            id: idx,
            name: 'User $idx',
            username: 'user$idx',
          ),
        );

        blocTest<UsersCubit, UsersState>(
          '''

WHEN the users list is requested
THEN the load process should be started
THEN the users repo should be used to retrieve the users
AND a set of users should be emitted
      ''',
          build: () {
            when(
              () => mockUsersRepo.getUsers(),
            ).thenAnswer(
              (_) async => Right(
                users,
              ),
            );

            return usersCubit;
          },
          act: (cubit) {
            cubit.load();
          },
          expect: () => [
            const UsersState.loading(),
            UsersState.loaded(users.toImmutableList()),
          ],
          verify: (bloc) {
            verify(() => mockUsersRepo.getUsers()).called(1);
            verifyNoMoreInteractions(mockUsersRepo);
          },
        );
      }

      blocTest<UsersCubit, UsersState>(
        '''

AND no internet connection
WHEN the users list is requested
THEN the load process should be started
THEN the users repo should be used to retrieve the users
AND a failure should be emitted
      ''',
        build: () {
          when(
            () => mockUsersRepo.getUsers(),
          ).thenAnswer(
            (_) async => const Left(
              GetUsersFailure.offline(),
            ),
          );

          return usersCubit;
        },
        act: (cubit) {
          cubit.load();
        },
        expect: () => [
          const UsersState.loading(),
          const UsersState.failed(
            UsersFailure.onGet(
              GetUsersFailure.offline(),
            ),
          ),
        ],
        verify: (bloc) {
          verify(() => mockUsersRepo.getUsers()).called(1);
          verifyNoMoreInteractions(mockUsersRepo);
        },
      );
    },
  );
}
