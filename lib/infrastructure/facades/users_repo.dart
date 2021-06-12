import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import '../../domain/facades/users_repo.dart';
import '../../domain/use_cases/get_users/use_case.dart';
import '../data_sources/users/remote/interface.dart';
import '../models/user.dart';

class UsersRepoImp extends UsersRepo {
  const UsersRepoImp({
    required this.usersRDS,
  });

  final UsersRDS usersRDS;

  @override
  Future<FailureOrUsers> getUsers() async {
    late final Set<UserR> usersR;

    try {
      usersR = await usersRDS.getUsers();
    } on GetUsersException catch (e) {
      return Left(
        e.when(
          offline: () => const GetUsersFailure.offline(),
        ),
      );
    }

    final users = usersR
        .map(
          (userR) => userR.asEntity,
        )
        .toImmutableSet();

    return Right(users);
  }
}
