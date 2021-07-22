import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// A GitHub user DTO.
///
/// This DTO offers JSON serialization.
@freezed
class UserDto with _$UserDto {
  /// Creates a GitHub user DTO.
  @JsonSerializable(explicitToJson: true)
  const factory UserDto({
    /// The nickname or username of this user.
    @JsonKey(name: 'login') required String username,

    /// The avatar URL of this user.
    @JsonKey(name: 'avatar_url') required String avatarUrl,
  }) = _UserDto;

  /// Creates a GitHub user DTO from the [json] `Map`.
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
