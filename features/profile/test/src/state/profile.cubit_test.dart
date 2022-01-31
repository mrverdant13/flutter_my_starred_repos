import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:profile/src/infrastructure/profile.repo.dart';
import 'package:profile/src/state/profile.cubit.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

void main() {
  group(
    '''

GIVEN a profile cubit
├─ THAT uses a profile repo''',
    () {
      // ARRANGE
      late ProfileRepo profileRepo;
      late ProfileCubit profileCubit;

      setUp(
        () {
          profileRepo = MockProfileRepo();
          profileCubit = ProfileCubit(profileRepo: profileRepo);
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
            profileCubit.state,
            const ProfileState.loading(profile: initialProfile),
          );
        },
      );

      {
        final updatedProfiles = Iterable.generate(
          4,
          (i) => Profile(
            username: 'username$i',
            avatarUrl: 'avatarUrl$i',
          ),
        );

        blocTest<ProfileCubit, ProfileState>(
          '''

WHEN the profile is watched
THEN the profile watch should be started
├─ BY emitting the loading state
├─ AND starting the profile watch with the profile repo
THEN the subsequent profiles should be emitted
├─ BY emitting loaded states
│  ├─ THAT wrap the updated profile
''',
          build: () => profileCubit,
          setUp: () => when(
            () => profileRepo.watchProfile(),
          ).thenAnswer(
            (_) => Stream.fromIterable(updatedProfiles),
          ),
          act: (cubit) => cubit.watchProfile(),
          expect: () => [
            const ProfileState.loading(profile: initialProfile),
            ...updatedProfiles.map((p) => ProfileState.loaded(profile: p)),
          ],
          verify: (_) => verify(() => profileRepo.watchProfile()).called(1),
        );
      }

      {
        const previousProfile = Profile(
          username: 'pre-username',
          avatarUrl: 'pre-avatarUrl',
        );

        blocTest<ProfileCubit, ProfileState>(
          '''

AND a previously loaded profile
WHEN the profile refresh is requested
THEN the profile refresh should be started
├─ BY emitting the loading state
│  ├─ THAT wraps the previous profile
├─ AND refreshing the profile with the profile repo
''',
          build: () => profileCubit,
          seed: () => const ProfileState.loaded(profile: previousProfile),
          setUp: () => when(
            () => profileRepo.refreshProfile(),
          ).thenAnswer(
            (_) async => Ok(unit),
          ),
          act: (cubit) => cubit.refreshProfile(),
          expect: () => [
            const ProfileState.loading(profile: previousProfile),
          ],
          verify: (_) => verify(() => profileRepo.refreshProfile()).called(1),
        );
      }

      {
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

        blocTest<ProfileCubit, ProfileState>(
          '''

AND a previously loaded profile
AND no minimal conditions
WHEN the profile refresh is requested
THEN the profile refresh should be started
├─ BY emitting the loading state
│  ├─ THAT wraps the previous profile
├─ AND trying to refresh the profile with the profile repo
THEN a failure state should be emited
├─ BY emitting a failure state
│  ├─ THAT wraps the refresh failure
''',
          build: () => profileCubit,
          seed: () => const ProfileState.loaded(profile: previousProfile),
          setUp: () => when(
            () => profileRepo.refreshProfile(),
          ).thenAnswer(
            (_) async => Err(expectedGetProfileFailure),
          ),
          act: (cubit) => cubit.refreshProfile(),
          expect: () => [
            const ProfileState.loading(profile: previousProfile),
            ProfileState.failure(
              profile: previousProfile,
              failure: expectedGetProfileFailure,
            ),
          ],
          verify: (_) => verify(() => profileRepo.refreshProfile()).called(1),
        );
      }
    },
  );
}
