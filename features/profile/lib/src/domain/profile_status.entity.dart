import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_status.entity.freezed.dart';
part 'profile_status.entity.g.dart';

@freezed
class UserStatus with _$UserStatus {
  const factory UserStatus({
    String? emoji,
    String? message,
  }) = _UserStatus;

  const UserStatus._();

  factory UserStatus.fromJson(Map<String, dynamic> json) =>
      _$UserStatusFromJson(json);

  bool get isValid => emoji != null || message != null;

  String get readable {
    final buf = StringBuffer();
    if (emoji != null) buf.write(emoji);
    if (emoji != null && message != null) buf.write(' ');
    if (message != null) buf.write(message);
    return buf.toString();
  }
}
