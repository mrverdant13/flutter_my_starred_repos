import '../use_cases/get_users/use_case.dart';

abstract class UsersRepo {
  const UsersRepo();

  Future<FailureOrUsers> getUsers();
}
