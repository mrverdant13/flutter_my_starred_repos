part of 'users_cubit.dart';

@freezed
class UsersFailure with _$UsersFailure {
  const factory UsersFailure.onGet(
    GetUsersFailure failure,
  ) = _UsersFailureOnGet;
}

@freezed
class UsersState with _$UsersState {
  const factory UsersState.idle() = _UsersStateIdle;
  const factory UsersState.loading() = _UsersStateLoading;
  const factory UsersState.loaded(
    KtSet<User> users,
  ) = _UsersStateLoaded;
  const factory UsersState.failed(
    UsersFailure failure,
  ) = _UsersStateFailed;
}
