import 'package:dartz/dartz.dart';

import '../../domain/get_users_failure.dart';
import '../../domain/user.dart';
import '../converters/user.dart';
import '../data_sources/users_rds/interface.dart';
import '../dto/user.dart';
import 'interface.dart';

class UsersRepoImp extends UsersRepo {
  const UsersRepoImp({
    required this.usersRDS,
  });

  final UsersRDS usersRDS;

  @override
  Future<Either<GetUsersFailure, List<User>>> getUsers() async {
    late final List<UserDto> usersDtos;

    try {
      usersDtos = await usersRDS.getUsers();
    } on GetUsersException catch (e) {
      return Left(
        e.when(
          offline: () => const GetUsersFailure.offline(),
        ),
      );
    }

    final users = usersDtos.map(
      (userDto) => userDto.asEntity,
    );

    return Right(users.toList());
  }
}
