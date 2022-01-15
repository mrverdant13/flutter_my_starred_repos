import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'login') required String username,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'avatar_url') required String avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
