import 'package:dartz/dartz.dart';

import '../../domain/get_users_failure.dart';
import '../../domain/user.dart';

abstract class UsersRepo {
  const UsersRepo();

  Future<Either<GetUsersFailure, List<User>>> getUsers();
}
