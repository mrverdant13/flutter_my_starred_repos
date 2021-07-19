import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_users_failure.freezed.dart';

@freezed
class GetUsersFailure with _$GetUsersFailure {
  const factory GetUsersFailure.offline() = _GetUsersFailureOffline;
}
