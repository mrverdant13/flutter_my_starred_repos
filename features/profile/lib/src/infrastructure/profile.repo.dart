import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:profile/src/infrastructure/profile.api.dart';

part 'profile.repo.freezed.dart';

class ProfileRepo {
  const ProfileRepo({
    required ProfileApi profileApi,
  }) : _profileApi = profileApi;

  final ProfileApi _profileApi;

  Future<Result<Profile, GetProfileFailure>> getProfile() async {
    try {
      final profile = await _profileApi.getProfile();
      return Ok(profile);
    } on GetProfileException catch (e) {
      return Err(
        e.when(
          offline: () => const GetProfileFailure.offline(),
        ),
      );
    }
  }
}

@freezed
class GetProfileFailure with _$GetProfileFailure {
  const factory GetProfileFailure.offline() = _GetProfileFailureOffline;
}
