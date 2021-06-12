import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/get_users/use_case.dart';

part 'users_cubit.freezed.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required GetUsers getUsers,
  })  : _getUsers = getUsers,
        super(
          const UsersState.idle(),
        );

  final GetUsers _getUsers;

  Future<void> load() async {
    emit(const UsersState.loading());

    final failureOrUsers = await _getUsers(null);

    emit(
      failureOrUsers.fold(
        (failure) => UsersState.failed(
          UsersFailure.onGet(
            failure,
          ),
        ),
        (users) => UsersState.loaded(
          users,
        ),
      ),
    );
  }
}
