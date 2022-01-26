import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:profile/src/infrastructure/profile.api.dart';
import 'package:profile/src/infrastructure/profile.storage.dart';

part 'profile.repo.freezed.dart';

class ProfileRepo {
  const ProfileRepo({
    required ProfileApi profileApi,
    required ProfileStorage profileStorage,
  })  : _profileApi = profileApi,
        _profileStorage = profileStorage;

  final ProfileApi _profileApi;
  final ProfileStorage _profileStorage;

  Future<Result<Profile, GetProfileFailure>> getProfile() async {
    try {
      final profile = await _profileApi.getProfile();
      await _profileStorage.setProfile(profile);
      return Ok(profile);
    } on GetProfileException catch (e) {
      return await e.when(
        offline: () async => Ok(await _profileStorage.profile),
        unexpected: () => Err(const GetProfileFailure.unexpected()),
      );
    }
  }
}

@freezed
class GetProfileFailure with _$GetProfileFailure {
  const factory GetProfileFailure.offline() = _GetProfileFailureOffline;
  const factory GetProfileFailure.unexpected() = _GetProfileFailureUnexpected;
}
