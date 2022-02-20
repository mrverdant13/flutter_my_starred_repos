import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:profile/src/infrastructure/profile.repo.dart';
import 'package:profile/src/state/profile.notifier.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

void main() {
  group(
    '''

GIVEN a profile notifier
├─ THAT uses a profile repo''',
    () {
      // ARRANGE
      late ProfileRepo profileRepo;
      late ProfileNotifier profileNotifier;

      setUp(
        () {
          profileRepo = MockProfileRepo();
          profileNotifier = ProfileNotifier(profileRepo: profileRepo);
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(profileRepo);
        },
      );

      test(
        '''

WHEN there is no interaction
THEN its initial state should be the loading state
''',
        () {
          // ASSERT
          expect(
            profileNotifier.debugState,
            const ProfileState.loading(profile: initialProfile),
          );
        },
      );

      test(
        '''

WHEN the profile is watched
THEN the profile watch should be started
├─ BY emitting the loading state
├─ AND starting the profile watch with the profile repo
THEN the subsequent profiles should be emitted
├─ BY emitting loaded states
│  ├─ THAT wrap the updated profile
''',
        () async {
          // ARRANGE
          const previousProfile = Profile(
            username: 'previousUsername',
            avatarUrl: 'previousAvatarUrl',
          );
          final updatedProfiles = Iterable.generate(
            4,
            (i) => Profile(
              username: 'username$i',
              avatarUrl: 'avatarUrl$i',
            ),
          );

          // ignore: invalid_use_of_protected_member
          profileNotifier.state = const ProfileState.loaded(
            profile: previousProfile,
          );

          when(
            () => profileRepo.watchProfile(),
          ).thenAnswer(
            (_) => Stream.fromFutures(
              updatedProfiles.map(
                Future.value,
              ),
            ),
          );

          final states = <ProfileState>[];
          profileNotifier.addListener(
            (profileState) => states.add(profileState),
            fireImmediately: false,
          );

          // ACT
          await profileNotifier.watchProfile();

          // ASSERT
          expect(
            states,
            [
              const ProfileState.loading(profile: previousProfile),
              ...updatedProfiles.map(
                (profile) => ProfileState.loaded(
                  profile: profile,
                ),
              ),
            ],
          );
          verify(() => profileRepo.watchProfile()).called(1);
        },
      );

      test(
        '''

AND a previously loaded profile
WHEN the profile refresh is requested
THEN the profile refresh should be started
├─ BY emitting the loading state
│  ├─ THAT wraps the previous profile
├─ AND refreshing the profile with the profile repo
''',
        () async {
          // ARRANGE
          const previousProfile = Profile(
            username: 'pre-username',
            avatarUrl: 'pre-avatarUrl',
          );

          // ignore: invalid_use_of_protected_member
          profileNotifier.state = const ProfileState.loaded(
            profile: previousProfile,
          );

          when(
            () => profileRepo.refreshProfile(),
          ).thenAnswer(
            (_) async => Ok(unit),
          );

          final states = <ProfileState>[];
          profileNotifier.addListener(
            (profileState) => states.add(profileState),
            fireImmediately: false,
          );

          // ACT
          await profileNotifier.refreshProfile();

          // ASSERT
          expect(
            states,
            [const ProfileState.loading(profile: previousProfile)],
          );
          verify(() => profileRepo.refreshProfile()).called(1);
        },
      );

      test(
        '''

AND a previously loaded profile
AND no minimal conditions
WHEN the profile refresh is requested
THEN the profile refresh should be started
├─ BY emitting the loading state
│  ├─ THAT wraps the previous profile
├─ AND trying to refresh the profile with the profile repo
THEN a failure state should be emitted
├─ BY emitting a failure state
│  ├─ THAT wraps the refresh failure
''',
        () async {
          // ARRANGE
          const previousProfile = Profile(
            username: 'pre-username',
            avatarUrl: 'pre-avatarUrl',
          );
          final r = Random();
          const possibleGetProfileFailures = [
            GetProfileFailure.offline(),
            GetProfileFailure.unexpected(),
          ];
          final expectedGetProfileFailure = possibleGetProfileFailures[
              r.nextInt(possibleGetProfileFailures.length)];

          // ignore: invalid_use_of_protected_member
          profileNotifier.state = const ProfileState.loaded(
            profile: previousProfile,
          );

          when(
            () => profileRepo.refreshProfile(),
          ).thenAnswer(
            (_) async => Err(expectedGetProfileFailure),
          );

          final states = <ProfileState>[];
          profileNotifier.addListener(
            (profileState) => states.add(profileState),
            fireImmediately: false,
          );

          // ACT
          await profileNotifier.refreshProfile();
          expect(
            states,
            [
              const ProfileState.loading(profile: previousProfile),
              ProfileState.failure(
                profile: previousProfile,
                failure: expectedGetProfileFailure,
              ),
            ],
          );
          verify(() => profileRepo.refreshProfile()).called(1);
        },
      );
    },
  );
}
