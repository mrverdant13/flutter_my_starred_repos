// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'users_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UsersFailureTearOff {
  const _$UsersFailureTearOff();

  _UsersFailureOnGet onGet(GetUsersFailure failure) {
    return _UsersFailureOnGet(
      failure,
    );
  }
}

/// @nodoc
const $UsersFailure = _$UsersFailureTearOff();

/// @nodoc
mixin _$UsersFailure {
  GetUsersFailure get failure => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetUsersFailure failure) onGet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetUsersFailure failure)? onGet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UsersFailureOnGet value) onGet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UsersFailureOnGet value)? onGet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UsersFailureCopyWith<UsersFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersFailureCopyWith<$Res> {
  factory $UsersFailureCopyWith(
          UsersFailure value, $Res Function(UsersFailure) then) =
      _$UsersFailureCopyWithImpl<$Res>;
  $Res call({GetUsersFailure failure});

  $GetUsersFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$UsersFailureCopyWithImpl<$Res> implements $UsersFailureCopyWith<$Res> {
  _$UsersFailureCopyWithImpl(this._value, this._then);

  final UsersFailure _value;
  // ignore: unused_field
  final $Res Function(UsersFailure) _then;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as GetUsersFailure,
    ));
  }

  @override
  $GetUsersFailureCopyWith<$Res> get failure {
    return $GetUsersFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc
abstract class _$UsersFailureOnGetCopyWith<$Res>
    implements $UsersFailureCopyWith<$Res> {
  factory _$UsersFailureOnGetCopyWith(
          _UsersFailureOnGet value, $Res Function(_UsersFailureOnGet) then) =
      __$UsersFailureOnGetCopyWithImpl<$Res>;
  @override
  $Res call({GetUsersFailure failure});

  @override
  $GetUsersFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$UsersFailureOnGetCopyWithImpl<$Res>
    extends _$UsersFailureCopyWithImpl<$Res>
    implements _$UsersFailureOnGetCopyWith<$Res> {
  __$UsersFailureOnGetCopyWithImpl(
      _UsersFailureOnGet _value, $Res Function(_UsersFailureOnGet) _then)
      : super(_value, (v) => _then(v as _UsersFailureOnGet));

  @override
  _UsersFailureOnGet get _value => super._value as _UsersFailureOnGet;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_UsersFailureOnGet(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as GetUsersFailure,
    ));
  }
}

/// @nodoc

class _$_UsersFailureOnGet implements _UsersFailureOnGet {
  const _$_UsersFailureOnGet(this.failure);

  @override
  final GetUsersFailure failure;

  @override
  String toString() {
    return 'UsersFailure.onGet(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UsersFailureOnGet &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$UsersFailureOnGetCopyWith<_UsersFailureOnGet> get copyWith =>
      __$UsersFailureOnGetCopyWithImpl<_UsersFailureOnGet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetUsersFailure failure) onGet,
  }) {
    return onGet(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetUsersFailure failure)? onGet,
    required TResult orElse(),
  }) {
    if (onGet != null) {
      return onGet(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UsersFailureOnGet value) onGet,
  }) {
    return onGet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UsersFailureOnGet value)? onGet,
    required TResult orElse(),
  }) {
    if (onGet != null) {
      return onGet(this);
    }
    return orElse();
  }
}

abstract class _UsersFailureOnGet implements UsersFailure {
  const factory _UsersFailureOnGet(GetUsersFailure failure) =
      _$_UsersFailureOnGet;

  @override
  GetUsersFailure get failure => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UsersFailureOnGetCopyWith<_UsersFailureOnGet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$UsersStateTearOff {
  const _$UsersStateTearOff();

  _UsersStateIdle idle() {
    return const _UsersStateIdle();
  }

  _UsersStateLoading loading() {
    return const _UsersStateLoading();
  }

  _UsersStateLoaded loaded(KtSet<User> users) {
    return _UsersStateLoaded(
      users,
    );
  }

  _UsersStateFailed failed(UsersFailure failure) {
    return _UsersStateFailed(
      failure,
    );
  }
}

/// @nodoc
const $UsersState = _$UsersStateTearOff();

/// @nodoc
mixin _$UsersState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(KtSet<User> users) loaded,
    required TResult Function(UsersFailure failure) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(KtSet<User> users)? loaded,
    TResult Function(UsersFailure failure)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UsersStateIdle value) idle,
    required TResult Function(_UsersStateLoading value) loading,
    required TResult Function(_UsersStateLoaded value) loaded,
    required TResult Function(_UsersStateFailed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UsersStateIdle value)? idle,
    TResult Function(_UsersStateLoading value)? loading,
    TResult Function(_UsersStateLoaded value)? loaded,
    TResult Function(_UsersStateFailed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersStateCopyWith<$Res> {
  factory $UsersStateCopyWith(
          UsersState value, $Res Function(UsersState) then) =
      _$UsersStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UsersStateCopyWithImpl<$Res> implements $UsersStateCopyWith<$Res> {
  _$UsersStateCopyWithImpl(this._value, this._then);

  final UsersState _value;
  // ignore: unused_field
  final $Res Function(UsersState) _then;
}

/// @nodoc
abstract class _$UsersStateIdleCopyWith<$Res> {
  factory _$UsersStateIdleCopyWith(
          _UsersStateIdle value, $Res Function(_UsersStateIdle) then) =
      __$UsersStateIdleCopyWithImpl<$Res>;
}

/// @nodoc
class __$UsersStateIdleCopyWithImpl<$Res> extends _$UsersStateCopyWithImpl<$Res>
    implements _$UsersStateIdleCopyWith<$Res> {
  __$UsersStateIdleCopyWithImpl(
      _UsersStateIdle _value, $Res Function(_UsersStateIdle) _then)
      : super(_value, (v) => _then(v as _UsersStateIdle));

  @override
  _UsersStateIdle get _value => super._value as _UsersStateIdle;
}

/// @nodoc

class _$_UsersStateIdle implements _UsersStateIdle {
  const _$_UsersStateIdle();

  @override
  String toString() {
    return 'UsersState.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _UsersStateIdle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(KtSet<User> users) loaded,
    required TResult Function(UsersFailure failure) failed,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(KtSet<User> users)? loaded,
    TResult Function(UsersFailure failure)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UsersStateIdle value) idle,
    required TResult Function(_UsersStateLoading value) loading,
    required TResult Function(_UsersStateLoaded value) loaded,
    required TResult Function(_UsersStateFailed value) failed,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UsersStateIdle value)? idle,
    TResult Function(_UsersStateLoading value)? loading,
    TResult Function(_UsersStateLoaded value)? loaded,
    TResult Function(_UsersStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _UsersStateIdle implements UsersState {
  const factory _UsersStateIdle() = _$_UsersStateIdle;
}

/// @nodoc
abstract class _$UsersStateLoadingCopyWith<$Res> {
  factory _$UsersStateLoadingCopyWith(
          _UsersStateLoading value, $Res Function(_UsersStateLoading) then) =
      __$UsersStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$UsersStateLoadingCopyWithImpl<$Res>
    extends _$UsersStateCopyWithImpl<$Res>
    implements _$UsersStateLoadingCopyWith<$Res> {
  __$UsersStateLoadingCopyWithImpl(
      _UsersStateLoading _value, $Res Function(_UsersStateLoading) _then)
      : super(_value, (v) => _then(v as _UsersStateLoading));

  @override
  _UsersStateLoading get _value => super._value as _UsersStateLoading;
}

/// @nodoc

class _$_UsersStateLoading implements _UsersStateLoading {
  const _$_UsersStateLoading();

  @override
  String toString() {
    return 'UsersState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _UsersStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(KtSet<User> users) loaded,
    required TResult Function(UsersFailure failure) failed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(KtSet<User> users)? loaded,
    TResult Function(UsersFailure failure)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UsersStateIdle value) idle,
    required TResult Function(_UsersStateLoading value) loading,
    required TResult Function(_UsersStateLoaded value) loaded,
    required TResult Function(_UsersStateFailed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UsersStateIdle value)? idle,
    TResult Function(_UsersStateLoading value)? loading,
    TResult Function(_UsersStateLoaded value)? loaded,
    TResult Function(_UsersStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _UsersStateLoading implements UsersState {
  const factory _UsersStateLoading() = _$_UsersStateLoading;
}

/// @nodoc
abstract class _$UsersStateLoadedCopyWith<$Res> {
  factory _$UsersStateLoadedCopyWith(
          _UsersStateLoaded value, $Res Function(_UsersStateLoaded) then) =
      __$UsersStateLoadedCopyWithImpl<$Res>;
  $Res call({KtSet<User> users});
}

/// @nodoc
class __$UsersStateLoadedCopyWithImpl<$Res>
    extends _$UsersStateCopyWithImpl<$Res>
    implements _$UsersStateLoadedCopyWith<$Res> {
  __$UsersStateLoadedCopyWithImpl(
      _UsersStateLoaded _value, $Res Function(_UsersStateLoaded) _then)
      : super(_value, (v) => _then(v as _UsersStateLoaded));

  @override
  _UsersStateLoaded get _value => super._value as _UsersStateLoaded;

  @override
  $Res call({
    Object? users = freezed,
  }) {
    return _then(_UsersStateLoaded(
      users == freezed
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as KtSet<User>,
    ));
  }
}

/// @nodoc

class _$_UsersStateLoaded implements _UsersStateLoaded {
  const _$_UsersStateLoaded(this.users);

  @override
  final KtSet<User> users;

  @override
  String toString() {
    return 'UsersState.loaded(users: $users)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UsersStateLoaded &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(users);

  @JsonKey(ignore: true)
  @override
  _$UsersStateLoadedCopyWith<_UsersStateLoaded> get copyWith =>
      __$UsersStateLoadedCopyWithImpl<_UsersStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(KtSet<User> users) loaded,
    required TResult Function(UsersFailure failure) failed,
  }) {
    return loaded(users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(KtSet<User> users)? loaded,
    TResult Function(UsersFailure failure)? failed,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UsersStateIdle value) idle,
    required TResult Function(_UsersStateLoading value) loading,
    required TResult Function(_UsersStateLoaded value) loaded,
    required TResult Function(_UsersStateFailed value) failed,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UsersStateIdle value)? idle,
    TResult Function(_UsersStateLoading value)? loading,
    TResult Function(_UsersStateLoaded value)? loaded,
    TResult Function(_UsersStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _UsersStateLoaded implements UsersState {
  const factory _UsersStateLoaded(KtSet<User> users) = _$_UsersStateLoaded;

  KtSet<User> get users => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$UsersStateLoadedCopyWith<_UsersStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UsersStateFailedCopyWith<$Res> {
  factory _$UsersStateFailedCopyWith(
          _UsersStateFailed value, $Res Function(_UsersStateFailed) then) =
      __$UsersStateFailedCopyWithImpl<$Res>;
  $Res call({UsersFailure failure});

  $UsersFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$UsersStateFailedCopyWithImpl<$Res>
    extends _$UsersStateCopyWithImpl<$Res>
    implements _$UsersStateFailedCopyWith<$Res> {
  __$UsersStateFailedCopyWithImpl(
      _UsersStateFailed _value, $Res Function(_UsersStateFailed) _then)
      : super(_value, (v) => _then(v as _UsersStateFailed));

  @override
  _UsersStateFailed get _value => super._value as _UsersStateFailed;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_UsersStateFailed(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as UsersFailure,
    ));
  }

  @override
  $UsersFailureCopyWith<$Res> get failure {
    return $UsersFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_UsersStateFailed implements _UsersStateFailed {
  const _$_UsersStateFailed(this.failure);

  @override
  final UsersFailure failure;

  @override
  String toString() {
    return 'UsersState.failed(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UsersStateFailed &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$UsersStateFailedCopyWith<_UsersStateFailed> get copyWith =>
      __$UsersStateFailedCopyWithImpl<_UsersStateFailed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(KtSet<User> users) loaded,
    required TResult Function(UsersFailure failure) failed,
  }) {
    return failed(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(KtSet<User> users)? loaded,
    TResult Function(UsersFailure failure)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UsersStateIdle value) idle,
    required TResult Function(_UsersStateLoading value) loading,
    required TResult Function(_UsersStateLoaded value) loaded,
    required TResult Function(_UsersStateFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UsersStateIdle value)? idle,
    TResult Function(_UsersStateLoading value)? loading,
    TResult Function(_UsersStateLoaded value)? loaded,
    TResult Function(_UsersStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _UsersStateFailed implements UsersState {
  const factory _UsersStateFailed(UsersFailure failure) = _$_UsersStateFailed;

  UsersFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$UsersStateFailedCopyWith<_UsersStateFailed> get copyWith =>
      throw _privateConstructorUsedError;
}
