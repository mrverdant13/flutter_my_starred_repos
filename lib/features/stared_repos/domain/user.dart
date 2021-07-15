import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// A GitHub user.
@freezed
class User with _$User {
  /// Creates a GitHub user.
  const factory User({
    /// The nickname or username of this user.
    required String username,

    /// The avatar URL of this user.
    required String avatarUrl,
  }) = _User;
}
