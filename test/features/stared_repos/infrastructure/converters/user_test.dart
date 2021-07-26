import 'package:flutter_my_starred_repos/features/stared_repos/domain/user.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/converters/user.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/dtos/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    '''

GIVEN a user DTO
WHEN it is mapped to a user entity
THEN a user entity with same data is created
''',
    () async {
      // ARRANGE
      const userUsername = 'username';
      const userAvatarUrl = 'avatar url';

      const userDto = UserDto(
        username: userUsername,
        avatarUrl: userAvatarUrl,
      );

      const expectedUser = User(
        username: userUsername,
        avatarUrl: userAvatarUrl,
      );

      // ACT
      final resultingUser = userDto.asEntity;

      // ASSERT
      expect(
        resultingUser,
        expectedUser,
      );
    },
  );
}
