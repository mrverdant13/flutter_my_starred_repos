import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

import '../../entities/user.dart';
import '../../facades/users_repo.dart';
import '../types.dart';

part 'failures.dart';
part 'use_case.freezed.dart';

typedef FailureOrUsers = Either<GetUsersFailure, KtSet<User>>;

class GetUsers extends FutureUseCase<GetUsersFailure, KtSet<User>, void> {
  const GetUsers({
    required this.usersRepo,
  });

  final UsersRepo usersRepo;

  @override
  Future<FailureOrUsers> call(_) => usersRepo.getUsers();
}
