// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'interface.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GetUsersExceptionTearOff {
  const _$GetUsersExceptionTearOff();

  _GetUsersExceptionOffline offline() {
    return const _GetUsersExceptionOffline();
  }
}

/// @nodoc
const $GetUsersException = _$GetUsersExceptionTearOff();

/// @nodoc
mixin _$GetUsersException {
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
    required TResult Function(_GetUsersExceptionOffline value) offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetUsersExceptionOffline value)? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetUsersExceptionCopyWith<$Res> {
  factory $GetUsersExceptionCopyWith(
          GetUsersException value, $Res Function(GetUsersException) then) =
      _$GetUsersExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetUsersExceptionCopyWithImpl<$Res>
    implements $GetUsersExceptionCopyWith<$Res> {
  _$GetUsersExceptionCopyWithImpl(this._value, this._then);

  final GetUsersException _value;
  // ignore: unused_field
  final $Res Function(GetUsersException) _then;
}

/// @nodoc
abstract class _$GetUsersExceptionOfflineCopyWith<$Res> {
  factory _$GetUsersExceptionOfflineCopyWith(_GetUsersExceptionOffline value,
          $Res Function(_GetUsersExceptionOffline) then) =
      __$GetUsersExceptionOfflineCopyWithImpl<$Res>;
}

/// @nodoc
class __$GetUsersExceptionOfflineCopyWithImpl<$Res>
    extends _$GetUsersExceptionCopyWithImpl<$Res>
    implements _$GetUsersExceptionOfflineCopyWith<$Res> {
  __$GetUsersExceptionOfflineCopyWithImpl(_GetUsersExceptionOffline _value,
      $Res Function(_GetUsersExceptionOffline) _then)
      : super(_value, (v) => _then(v as _GetUsersExceptionOffline));

  @override
  _GetUsersExceptionOffline get _value =>
      super._value as _GetUsersExceptionOffline;
}

/// @nodoc

class _$_GetUsersExceptionOffline implements _GetUsersExceptionOffline {
  const _$_GetUsersExceptionOffline();

  @override
  String toString() {
    return 'GetUsersException.offline()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _GetUsersExceptionOffline);
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
    required TResult Function(_GetUsersExceptionOffline value) offline,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetUsersExceptionOffline value)? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class _GetUsersExceptionOffline implements GetUsersException {
  const factory _GetUsersExceptionOffline() = _$_GetUsersExceptionOffline;
}
