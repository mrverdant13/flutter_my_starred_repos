import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user.freezed.dart';
part 'user.g.dart';
part 'user_converters.dart';

@freezed
class UserR with _$UserR {
  const factory UserR({
    required int id,
    required String name,
    required String username,
  }) = _UserR;

  factory UserR.fromJson(Map<String, dynamic> json) => _$UserRFromJson(json);
}
