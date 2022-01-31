import 'package:flutter_test/flutter_test.dart';
import 'package:profile/src/domain/profile_status.entity.dart';

void main() {
  test(
    '''

GIVEN a user status
├─ THAT does not have an emoji
├─ AND does not have a message
WHEN the status validity is checked
THEN a negative result should be returned
''',
    () {
      // ARRANGE
      const status = UserStatus();

      // ACT
      final result = status.isValid;

      // ASSERT
      expect(result, isFalse);
    },
  );

  test(
    '''

GIVEN a user status
├─ THAT has an emoji
├─ AND does not have a message
WHEN the status validity is checked
THEN a positive result should be returned
''',
    () {
      // ARRANGE
      const status = UserStatus(emoji: '😀');

      // ACT
      final result = status.isValid;

      // ASSERT
      expect(result, isTrue);
    },
  );

  test(
    '''

GIVEN a user status
├─ THAT does not have an emoji
├─ AND has a message
WHEN the status validity is checked
THEN a positive result should be returned
''',
    () {
      // ARRANGE
      const status = UserStatus(message: 'Hello world!');

      // ACT
      final result = status.isValid;

      // ASSERT
      expect(result, isTrue);
    },
  );

  test(
    '''

GIVEN a user status
├─ THAT has an emoji
├─ AND has a message
WHEN the status validity is checked
THEN a positive result should be returned
''',
    () {
      // ARRANGE
      const status = UserStatus(emoji: '😀', message: 'Hello world!');

      // ACT
      final result = status.isValid;

      // ASSERT
      expect(result, isTrue);
    },
  );

  test(
    '''

GIVEN a user status
├─ THAT does not have an emoji
├─ AND does not have a message
WHEN the readable representation of the status is requested
THEN an empty string should be returned
''',
    () {
      // ARRANGE
      const status = UserStatus();

      // ACT
      final result = status.readable;

      // ASSERT
      expect(result, isEmpty);
    },
  );

  test(
    '''

GIVEN a user status
├─ THAT has an emoji
├─ AND does not have a message
WHEN the readable representation of the status is requested
THEN the emoji should be returned
''',
    () {
      // ARRANGE
      const emoji = '😀';
      const status = UserStatus(emoji: emoji);

      // ACT
      final result = status.readable;

      // ASSERT
      expect(result, emoji);
    },
  );

  test(
    '''

GIVEN a user status
├─ THAT does not have an emoji
├─ AND has a message
WHEN the readable representation of the status is requested
THEN the message should be returned
''',
    () {
      // ARRANGE
      const message = 'Hello world!';
      const status = UserStatus(message: message);

      // ACT
      final result = status.readable;

      // ASSERT
      expect(result, message);
    },
  );

  test(
    '''

GIVEN a user status
├─ THAT has an emoji
├─ AND has a message
WHEN the readable representation of the status is requested
THEN the emoji and the message should be returned
''',
    () {
      // ARRANGE
      const emoji = '😀';
      const message = 'Hello world!';
      const status = UserStatus(emoji: emoji, message: message);

      // ACT
      final result = status.readable;

      // ASSERT
      expect(result, '$emoji $message');
    },
  );
}
