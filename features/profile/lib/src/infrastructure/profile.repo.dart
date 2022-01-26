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

  Future<Result<Unit, GetProfileFailure>> refreshProfile() async {
    try {
      final profile = await _profileApi.getProfile();
      await _profileStorage.setProfile(profile);
      return Ok(unit);
    } on GetProfileException catch (e) {
      return Err(
        e.when(
          offline: () => const GetProfileFailure.offline(),
          unexpected: () => const GetProfileFailure.unexpected(),
        ),
      );
    }
  }

  Stream<Profile> watchProfile() => _profileStorage.watchProfile();
}

@freezed
class GetProfileFailure with _$GetProfileFailure {
  const factory GetProfileFailure.offline() = _GetProfileFailureOffline;
  const factory GetProfileFailure.unexpected() = _GetProfileFailureUnexpected;
}
