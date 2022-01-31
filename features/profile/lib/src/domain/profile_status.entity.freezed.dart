// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_status.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserStatus _$UserStatusFromJson(Map<String, dynamic> json) {
  return _UserStatus.fromJson(json);
}

/// @nodoc
class _$UserStatusTearOff {
  const _$UserStatusTearOff();

  _UserStatus call({String? emoji, String? message}) {
    return _UserStatus(
      emoji: emoji,
      message: message,
    );
  }

  UserStatus fromJson(Map<String, Object?> json) {
    return UserStatus.fromJson(json);
  }
}

/// @nodoc
const $UserStatus = _$UserStatusTearOff();

/// @nodoc
mixin _$UserStatus {
  String? get emoji => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStatusCopyWith<UserStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatusCopyWith<$Res> {
  factory $UserStatusCopyWith(
          UserStatus value, $Res Function(UserStatus) then) =
      _$UserStatusCopyWithImpl<$Res>;
  $Res call({String? emoji, String? message});
}

/// @nodoc
class _$UserStatusCopyWithImpl<$Res> implements $UserStatusCopyWith<$Res> {
  _$UserStatusCopyWithImpl(this._value, this._then);

  final UserStatus _value;
  // ignore: unused_field
  final $Res Function(UserStatus) _then;

  @override
  $Res call({
    Object? emoji = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      emoji: emoji == freezed
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$UserStatusCopyWith<$Res> implements $UserStatusCopyWith<$Res> {
  factory _$UserStatusCopyWith(
          _UserStatus value, $Res Function(_UserStatus) then) =
      __$UserStatusCopyWithImpl<$Res>;
  @override
  $Res call({String? emoji, String? message});
}

/// @nodoc
class __$UserStatusCopyWithImpl<$Res> extends _$UserStatusCopyWithImpl<$Res>
    implements _$UserStatusCopyWith<$Res> {
  __$UserStatusCopyWithImpl(
      _UserStatus _value, $Res Function(_UserStatus) _then)
      : super(_value, (v) => _then(v as _UserStatus));

  @override
  _UserStatus get _value => super._value as _UserStatus;

  @override
  $Res call({
    Object? emoji = freezed,
    Object? message = freezed,
  }) {
    return _then(_UserStatus(
      emoji: emoji == freezed
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserStatus extends _UserStatus {
  const _$_UserStatus({this.emoji, this.message}) : super._();

  factory _$_UserStatus.fromJson(Map<String, dynamic> json) =>
      _$$_UserStatusFromJson(json);

  @override
  final String? emoji;
  @override
  final String? message;

  @override
  String toString() {
    return 'UserStatus(emoji: $emoji, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserStatus &&
            const DeepCollectionEquality().equals(other.emoji, emoji) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(emoji),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$UserStatusCopyWith<_UserStatus> get copyWith =>
      __$UserStatusCopyWithImpl<_UserStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStatusToJson(this);
  }
}

abstract class _UserStatus extends UserStatus {
  const factory _UserStatus({String? emoji, String? message}) = _$_UserStatus;
  const _UserStatus._() : super._();

  factory _UserStatus.fromJson(Map<String, dynamic> json) =
      _$_UserStatus.fromJson;

  @override
  String? get emoji;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$UserStatusCopyWith<_UserStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
