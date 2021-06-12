// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'use_case.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GetUsersFailureTearOff {
  const _$GetUsersFailureTearOff();

  _GetUsersFailureOffline offline() {
    return const _GetUsersFailureOffline();
  }
}

/// @nodoc
const $GetUsersFailure = _$GetUsersFailureTearOff();

/// @nodoc
mixin _$GetUsersFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetUsersFailureOffline value) offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetUsersFailureOffline value)? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetUsersFailureCopyWith<$Res> {
  factory $GetUsersFailureCopyWith(
          GetUsersFailure value, $Res Function(GetUsersFailure) then) =
      _$GetUsersFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetUsersFailureCopyWithImpl<$Res>
    implements $GetUsersFailureCopyWith<$Res> {
  _$GetUsersFailureCopyWithImpl(this._value, this._then);

  final GetUsersFailure _value;
  // ignore: unused_field
  final $Res Function(GetUsersFailure) _then;
}

/// @nodoc
abstract class _$GetUsersFailureOfflineCopyWith<$Res> {
  factory _$GetUsersFailureOfflineCopyWith(_GetUsersFailureOffline value,
          $Res Function(_GetUsersFailureOffline) then) =
      __$GetUsersFailureOfflineCopyWithImpl<$Res>;
}

/// @nodoc
class __$GetUsersFailureOfflineCopyWithImpl<$Res>
    extends _$GetUsersFailureCopyWithImpl<$Res>
    implements _$GetUsersFailureOfflineCopyWith<$Res> {
  __$GetUsersFailureOfflineCopyWithImpl(_GetUsersFailureOffline _value,
      $Res Function(_GetUsersFailureOffline) _then)
      : super(_value, (v) => _then(v as _GetUsersFailureOffline));

  @override
  _GetUsersFailureOffline get _value => super._value as _GetUsersFailureOffline;
}

/// @nodoc

class _$_GetUsersFailureOffline implements _GetUsersFailureOffline {
  const _$_GetUsersFailureOffline();

  @override
  String toString() {
    return 'GetUsersFailure.offline()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _GetUsersFailureOffline);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
  }) {
    return offline();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetUsersFailureOffline value) offline,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetUsersFailureOffline value)? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class _GetUsersFailureOffline implements GetUsersFailure {
  const factory _GetUsersFailureOffline() = _$_GetUsersFailureOffline;
}
