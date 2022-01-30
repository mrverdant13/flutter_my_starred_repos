import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:profile/src/infrastructure/profile.api.dart';
import 'package:profile/src/infrastructure/profile.repo.dart';
import 'package:profile/src/infrastructure/profile.storage.dart';

class MockProfileApi extends Mock implements ProfileApi {}

class MockProfileStorage extends Mock implements ProfileStorage {}

class FakeProfile extends Fake implements Profile {}

void main() {
  group(
    '''

GIVEN a profile repo
├─ THAT uses a profile API
├─ AND uses a profile storage''',
    () {
      // ARRANGE
      late ProfileApi profileApi;
      late ProfileStorage profileStorage;
      late ProfileRepo profileRepo;

      setUpAll(
        () {
          registerFallbackValue(FakeProfile());
        },
      );

      setUp(
        () {
          profileApi = MockProfileApi();
          profileStorage = MockProfileStorage();
          profileRepo = ProfileRepo(
            profileApi: profileApi,
            profileStorage: profileStorage,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(profileApi);
          verifyNoMoreInteractions(profileStorage);
        },
      );

      test(
        '''

WHEN the profile refresh is triggered
THEN the profile should be updated
├─ BY retrieving the latest profile with the profile API
├─ AND storing the profile with the profile storage
├─ AND not returning any value
''',
        () async {
          // ARRANGE
          const profile = Profile(
            username: 'username',
            avatarUrl: 'avatarUrl',
          );
          when(
            () => profileApi.getProfile(),
          ).thenAnswer(
            (_) async => profile,
          );
          when(
            () => profileStorage.setProfile(
              any(),
            ),
          ).thenAnswer(
            (_) async {},
          );

          // ACT
          final result = await profileRepo.refreshProfile();

          // ASSERT
          verify(() => profileApi.getProfile()).called(1);
          verify(() => profileStorage.setProfile(profile)).called(1);
          expect(result, Ok<Unit, GetProfileFailure>(unit));
        },
      );

      test(
        '''

AND connectivity issues
WHEN the profile refresh is triggered
THEN a failure should be returned
├─ BY trying to retrieve the latest profile with the profile API
├─ AND returning a failure identifying the issue
''',
        () async {
          // ARRANGE
          when(
            () => profileApi.getProfile(),
          ).thenThrow(
            const GetProfileException.offline(),
          );

          // ACT
          final result = await profileRepo.refreshProfile();

          // ASSERT
          verify(() => profileApi.getProfile()).called(1);
          expect(
            result,
            Err<Unit, GetProfileFailure>(const GetProfileFailure.offline()),
          );
        },
      );

      test(
        '''

AND unexpected issues
WHEN the profile refresh is triggered
THEN a failure should be returned
├─ BY trying to retrieve the latest profile with the profile API
├─ AND returning a failure identifying the issue
''',
        () async {
          // ARRANGE
          when(
            () => profileApi.getProfile(),
          ).thenThrow(
            const GetProfileException.unexpected(),
          );

          // ACT
          final result = await profileRepo.refreshProfile();

          // ASSERT
          verify(() => profileApi.getProfile()).called(1);
          expect(
            result,
            Err<Unit, GetProfileFailure>(const GetProfileFailure.unexpected()),
          );
        },
      );

      test(
        '''

WHEN the profile is watched
THEN the profile should be returned on any changes
├─ BY watching the profile with the profile storage
''',
        () async {
          // ARRANGE
          final profiles = List.generate(
            10,
            (index) => Profile(
              username: 'username$index',
              avatarUrl: 'avatarUrl$index',
            ),
          );
          when(
            () => profileStorage.watchProfile(),
          ).thenAnswer(
            (_) => Stream.fromIterable(profiles),
          );

          // ACT
          final result = profileRepo.watchProfile();

          // ASSERT
          verify(() => profileStorage.watchProfile()).called(1);
          expect(result, emitsInOrder(profiles));
        },
      );
    },
  );
}
