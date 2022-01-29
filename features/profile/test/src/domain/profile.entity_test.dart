import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/profile.dart';

class MockUserStatus extends Mock implements UserStatus {}

void main() {
  test(
    '''

GIVEN a profile instance
├─ THAT does not have a status
WHEN the status validity is checked
THEN a negative result should be returned
''',
    () {
      // ARRANGE
      const profile = Profile(
        username: 'username',
        avatarUrl: 'avatarUrl',
        name: 'name',
      );

      // ACT
      final result = profile.hasValidStatus;

      // ASSERT
      expect(result, isFalse);
    },
  );

  test(
    '''

GIVEN a profile instance
├─ THAT has a status
│  ├─ THAT is not valid
WHEN the status validity is checked
THEN a negative result should be returned
''',
    () {
      // ARRANGE
      final userStatus = MockUserStatus();
      final profile = Profile(
        username: 'username',
        avatarUrl: 'avatarUrl',
        name: 'name',
        status: userStatus,
      );
      when(() => userStatus.isValid).thenReturn(false);

      // ACT
      final result = profile.hasValidStatus;

      // ASSERT
      expect(result, isFalse);
    },
  );
}
