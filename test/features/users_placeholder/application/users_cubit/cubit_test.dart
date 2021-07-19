import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app_template/features/users_placeholder/application/users_cubit/cubit.dart';
import 'package:flutter_app_template/features/users_placeholder/domain/get_users_failure.dart';
import 'package:flutter_app_template/features/users_placeholder/domain/user.dart';
import 'package:flutter_app_template/features/users_placeholder/infrastructure/facades/interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersRepo extends Mock implements UsersRepo {}

void main() {
  group(
    '''

GIVEN a users cubit''',
    () {
      // Facades
      late MockUsersRepo mockUsersRepo;

      // Cubit
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
THEN its initial state is idle
''',
        () async {
          // ARRANGE

          // ACT

          // ASSERT
          expect(usersCubit.state, const UsersState.idle());
        },
      );

      {
        final users = [
          const User(id: 1, name: 'User 1', username: 'user1'),
          const User(id: 2, name: 'User 2', username: 'user2'),
          const User(id: 3, name: 'User 3', username: 'user3'),
        ];

        blocTest<UsersCubit, UsersState>(
          '''

WHEN the users list is requested
THEN the load process is started
THEN a set of users is emited
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

      group(
        '''

AND no internet connection''',
        () {
          blocTest<UsersCubit, UsersState>(
            '''

WHEN the users list is requested
THEN the load process is started
THEN a failure is emited
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
    },
  );
}
