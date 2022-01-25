// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile.api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GetProfileExceptionTearOff {
  const _$GetProfileExceptionTearOff();

  _GetProfileExceptionOffline offline() {
    return const _GetProfileExceptionOffline();
  }
}

/// @nodoc
const $GetProfileException = _$GetProfileExceptionTearOff();

/// @nodoc
mixin _$GetProfileException {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? offline,
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
    required TResult Function(_GetProfileExceptionOffline value) offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_GetProfileExceptionOffline value)? offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetProfileExceptionOffline value)? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProfileExceptionCopyWith<$Res> {
  factory $GetProfileExceptionCopyWith(
          GetProfileException value, $Res Function(GetProfileException) then) =
      _$GetProfileExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetProfileExceptionCopyWithImpl<$Res>
    implements $GetProfileExceptionCopyWith<$Res> {
  _$GetProfileExceptionCopyWithImpl(this._value, this._then);

  final GetProfileException _value;
  // ignore: unused_field
  final $Res Function(GetProfileException) _then;
}

/// @nodoc
abstract class _$GetProfileExceptionOfflineCopyWith<$Res> {
  factory _$GetProfileExceptionOfflineCopyWith(
          _GetProfileExceptionOffline value,
          $Res Function(_GetProfileExceptionOffline) then) =
      __$GetProfileExceptionOfflineCopyWithImpl<$Res>;
}

/// @nodoc
class __$GetProfileExceptionOfflineCopyWithImpl<$Res>
    extends _$GetProfileExceptionCopyWithImpl<$Res>
    implements _$GetProfileExceptionOfflineCopyWith<$Res> {
  __$GetProfileExceptionOfflineCopyWithImpl(_GetProfileExceptionOffline _value,
      $Res Function(_GetProfileExceptionOffline) _then)
      : super(_value, (v) => _then(v as _GetProfileExceptionOffline));

  @override
  _GetProfileExceptionOffline get _value =>
      super._value as _GetProfileExceptionOffline;
}

/// @nodoc

class _$_GetProfileExceptionOffline implements _GetProfileExceptionOffline {
  const _$_GetProfileExceptionOffline();

  @override
  String toString() {
    return 'GetProfileException.offline()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetProfileExceptionOffline);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? offline,
  }) {
    return offline?.call();
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
    required TResult Function(_GetProfileExceptionOffline value) offline,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_GetProfileExceptionOffline value)? offline,
  }) {
    return offline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetProfileExceptionOffline value)? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class _GetProfileExceptionOffline implements GetProfileException {
  const factory _GetProfileExceptionOffline() = _$_GetProfileExceptionOffline;
}
