import 'package:dartz/dartz.dart';
import 'package:flutter_app_template/domain/entities/user.dart';
import 'package:flutter_app_template/domain/facades/users_repo.dart';
import 'package:flutter_app_template/domain/use_cases/get_users/use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersRepo extends Mock implements UsersRepo {}

void main() {
  // Facades
  final mockUsersRepo = MockUsersRepo();

  // Use case
  final getUsers = GetUsers(
    usersRepo: mockUsersRepo,
  );

  test(
    '''

GIVEN a users repo
WHEN the users list is requested
THEN a collection of users is returned
''',
    () async {
      // ARRANGE
      final users = const [
        User(id: 1, name: 'User 1', username: 'user1'),
        User(id: 2, name: 'User 2', username: 'user2'),
        User(id: 3, name: 'User 3', username: 'user3'),
      ].toImmutableSet();

      when(
        () => mockUsersRepo.getUsers(),
      ).thenAnswer(
        (_) async => Right(
          users,
        ),
      );

      // ACT
      final result = await getUsers(null);

      // ASSERT
      expect(result, Right(users));
      verify(() => mockUsersRepo.getUsers()).called(1);
      verifyNoMoreInteractions(mockUsersRepo);
    },
  );
}
