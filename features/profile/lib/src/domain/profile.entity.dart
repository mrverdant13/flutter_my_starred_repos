import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:profile/src/domain/profile_status.entity.dart';

part 'profile.entity.freezed.dart';
part 'profile.entity.g.dart';

@freezed
class Profile with _$Profile {
  // coverage:ignore-start
  const factory Profile({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'login') required String username,
    required String avatarUrl,
    String? name,
    UserStatus? status,
  }) = _Profile;

  const Profile._();

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
// coverage:ignore-end

  bool get hasValidStatus => status != null && status!.isValid;
}
