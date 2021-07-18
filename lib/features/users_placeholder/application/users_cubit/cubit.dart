import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import '../../domain/get_users_failure.dart';
import '../../domain/user.dart';
import '../../infrastructure/facades/interface.dart';

part 'cubit.freezed.dart';
part 'state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required UsersRepo usersRepo,
  })  : _usersRepo = usersRepo,
        super(
          const UsersState.idle(),
        );

  final UsersRepo _usersRepo;

  Future<void> load() async {
    emit(const UsersState.loading());

    final failureOrUsers = await _usersRepo.getUsers();

    emit(
      failureOrUsers.fold(
        (failure) => UsersState.failed(
          UsersFailure.onGet(
            failure,
          ),
        ),
        (users) => UsersState.loaded(
          users.toImmutableList(),
        ),
      ),
    );
  }
}
