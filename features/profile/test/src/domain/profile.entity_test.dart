import 'package:flutter_test/flutter_test.dart';
import 'package:profile/src/domain/profile.entity.dart';

void main() {
  // ARRANGE
  const username = 'username';
  const name = 'name';
  const avatarUrl = 'avatarUrl';

  test(
    '''

GIVEN a user data
WHEN a profile construction is requested
THEN a profile instance should be created
''',
    () {
      // ACT
      const profile = Profile(
        username: username,
        name: name,
        avatarUrl: avatarUrl,
      );

      // ASSERT
      expect(profile, isA<Profile>());
    },
  );

  test(
    '''

GIVEN a user JSON representation
WHEN a profile construction is requested from the JSON data
THEN a profile instance should be created
''',
    () {
      // ARRANGE
      final userJson = {
        'login': username,
        'name': name,
        'avatarUrl': avatarUrl,
      };

      // ACT
      final profile = Profile.fromJson(userJson);

      // ASSERT
      expect(profile, isA<Profile>());
      expect(username, profile.username);
      expect(name, profile.name);
      expect(avatarUrl, profile.avatarUrl);
    },
  );

  test(
    '''

GIVEN a profile instance
WHEN the serialized representation is requested
THEN a JSON representation should be returned
''',
    () {
      // ARRANGE
      const profile = Profile(
        username: username,
        name: name,
        avatarUrl: avatarUrl,
      );

      // ACT
      final profileJson = profile.toJson();

      // ASSERT
      expect(profileJson, isA<Map<String, dynamic>>());
      expect(username, profileJson['login']);
      expect(name, profileJson['name']);
      expect(avatarUrl, profileJson['avatarUrl']);
    },
  );
}
