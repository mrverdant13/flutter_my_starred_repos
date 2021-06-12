import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/user.dart';

part 'interface.freezed.dart';

abstract class UsersRDS {
  const UsersRDS();

  /// Get users.
  ///
  /// Throws [GetUsersException]:
  /// - [GetUsersException.offline]: No internet connection.
  Future<Set<UserR>> getUsers();
}

/// Exceptions thrown by the [UsersRDS.getUsers] method.
@freezed
class GetUsersException with _$GetUsersException {
  const factory GetUsersException.offline() = _GetUsersExceptionOffline;
}
