import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey(name: 'login') required String username,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
