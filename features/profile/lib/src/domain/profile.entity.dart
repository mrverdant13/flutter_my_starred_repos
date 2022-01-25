import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.entity.freezed.dart';
part 'profile.entity.g.dart';

@freezed
class Profile with _$Profile {
// coverage:ignore-start
  const factory Profile({
// coverage:ignore-end
    // ignore: invalid_annotation_target
    @JsonKey(name: 'login') required String username,
    required String? name,
    required String avatarUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
