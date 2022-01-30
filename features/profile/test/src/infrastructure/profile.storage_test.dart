import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/profile.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';

class MockStoreRef extends Mock
    implements StoreRef<String, Map<String, dynamic>> {}

class FakeRecordRef extends Fake
    implements RecordRef<String, Map<String, dynamic>> {
  FakeRecordRef({
    required this.getValue,
    required this.onSnapshotValues,
  });

  final Map<String, dynamic> getValue;
  final Map<String, Map<String, dynamic>> onSnapshotValues;

  // Implementation needed to use the `get` and `onSnapshot` methods, which are
  // extension methods, in tests.

  Future<Map<String, dynamic>?> get(
    Database database,
  ) async =>
      getValue;

  Stream<RecordSnapshot<String, Map<String, dynamic>>?> onSnapshot(
    Database database,
  ) =>
      Stream.fromIterable(
        onSnapshotValues.entries.map(
          (e) => FakeRecordSnapshot(
            key: e.key,
            value: e.value,
          ),
        ),
      );
}

class FakeDatabase extends Mock implements Database {}

class FakeRecordSnapshot extends Fake
    implements RecordSnapshot<String, Map<String, dynamic>> {
  FakeRecordSnapshot({
    required this.key,
    required this.value,
  });

  @override
  final String key;

  @override
  final Map<String, dynamic> value;
}

void main() {
  group(
    '''

GIVEN a profile storage
├─ THAT uses a Sembast database''',
    () {
      // ARRANGE
      late Database sembastDb;
      late ProfileStorage profileStorage;

      setUp(
        () async {
          sembastDb = await databaseFactoryMemory.openDatabase(
            sembastInMemoryDatabasePath,
          );
          profileStorage = ProfileStorage(
            sembastDatabase: sembastDb,
          );
        },
      );

      test(
        '''

WHEN a profile is sent to be stored
THEN the profile should be persisted
├─ BY storing the profile in the database
''',
        () async {
          // ARRANGE
          const profile = Profile(username: 'username', avatarUrl: 'avatarUrl');

          // ACT
          await profileStorage.setProfile(profile);

          // ASSERT
          final storedProfile = await profileStorage.store
              .record(ProfileStorage.storeKey)
              .get(sembastDb);
          expect(storedProfile, profile.toJson());
        },
      );

      // Test profile getter
      test(
        '''

AND a previously persisted profile
WHEN the profile is requested
THEN the profile should be returned
├─ BY retrieving the persisted raw profile from the database
├─ AND returning the serialized profile
''',
        () async {
          // ARRANGE
          const profile = Profile(username: 'username', avatarUrl: 'avatarUrl');
          final profileJson = profile.toJson();
          await profileStorage.store
              .record(ProfileStorage.storeKey)
              .put(sembastDb, profileJson);
          final storedProfile = await profileStorage.store
              .record(ProfileStorage.storeKey)
              .get(sembastDb);
          expect(storedProfile, profileJson);

          // ACT
          final result = await profileStorage.profile;

          // ASSERT
          expect(result, profile);
        },
      );

      test(
        '''

AND a previously persisted profile
WHEN the profile is watched
THEN the profile should be continuously returned
├─ BY reading the raw profile from the database every time it changes
├─ AND returning the serialized profile
''',
        () async {
          // ARRANGE
          const changesCount = 4;
          final updatedProfiles = List.generate(
            changesCount,
            (index) => Profile(
              username: 'user$index',
              avatarUrl: 'url$index',
            ),
          );
          const initialProfile = Profile(username: 'user', avatarUrl: 'url');
          final initialProfileJson = initialProfile.toJson();
          await profileStorage.record.put(sembastDb, initialProfileJson);
          final storedProfile = await profileStorage.record.get(sembastDb);
          expect(storedProfile, initialProfileJson);

          // ACT
          final result = profileStorage.watchProfile();
          final appliedUpdatedProfiles = <Profile>[];
          late final StreamSubscription subscription;
          subscription = profileStorage.record.onSnapshot(sembastDb).listen(
            (snapshot) async {
              final newProfile = updatedProfiles[appliedUpdatedProfiles.length];
              appliedUpdatedProfiles.add(newProfile);
              await profileStorage.record.put(
                sembastDb,
                newProfile.toJson(),
              );
              if (updatedProfiles.length == appliedUpdatedProfiles.length) {
                await subscription.cancel();
              }
            },
          );

          // ASSERT
          expectLater(
            result,
            emitsInOrder([
              initialProfile,
              ...updatedProfiles,
            ]),
          );
        },
      );
    },
  );
}
