import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app_template/domain/entities/user.dart';
import 'package:flutter_app_template/domain/use_cases/get_users/use_case.dart';
import 'package:flutter_app_template/application/cubit/users/users_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  group(
    '''

GIVEN a users cubit''',
    () {
      // Use cases
      late MockGetUsers mockGetUsers;

      // Cubit
      late UsersCubit usersCubit;

      setUp(
        () {
          mockGetUsers = MockGetUsers();
          usersCubit = UsersCubit(
            getUsers: mockGetUsers,
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
        final users = const [
          User(id: 1, name: 'User 1', username: 'user1'),
          User(id: 2, name: 'User 2', username: 'user2'),
          User(id: 3, name: 'User 3', username: 'user3'),
        ].toImmutableSet();

        blocTest<UsersCubit, UsersState>(
          '''

WHEN the users list is requested
THEN the load process is started
THEN a set of users is emited
      ''',
          build: () {
            when(
              () => mockGetUsers(
                any(),
              ),
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
            UsersState.loaded(users),
          ],
          verify: (bloc) {
            verify(() => mockGetUsers.call(null)).called(1);
            verifyNoMoreInteractions(mockGetUsers);
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
                () => mockGetUsers(
                  any(),
                ),
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
              verify(() => mockGetUsers.call(null)).called(1);
              verifyNoMoreInteractions(mockGetUsers);
            },
          );
        },
      );
    },
  );
}
