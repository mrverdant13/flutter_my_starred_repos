// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginMethodTearOff {
  const _$LoginMethodTearOff();

  _LoginMethodOAuth oAuth({required OAuthCallback callback}) {
    return _LoginMethodOAuth(
      callback: callback,
    );
  }
}

/// @nodoc
const $LoginMethod = _$LoginMethodTearOff();

/// @nodoc
mixin _$LoginMethod {
  /// The callback used for the auth process.
  OAuthCallback get callback => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OAuthCallback callback) oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OAuthCallback callback)? oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OAuthCallback callback)? oAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginMethodOAuth value) oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginMethodOAuth value)? oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginMethodOAuth value)? oAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginMethodCopyWith<LoginMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginMethodCopyWith<$Res> {
  factory $LoginMethodCopyWith(
          LoginMethod value, $Res Function(LoginMethod) then) =
      _$LoginMethodCopyWithImpl<$Res>;
  $Res call({OAuthCallback callback});
}

/// @nodoc
class _$LoginMethodCopyWithImpl<$Res> implements $LoginMethodCopyWith<$Res> {
  _$LoginMethodCopyWithImpl(this._value, this._then);

  final LoginMethod _value;
  // ignore: unused_field
  final $Res Function(LoginMethod) _then;

  @override
  $Res call({
    Object? callback = freezed,
  }) {
    return _then(_value.copyWith(
      callback: callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as OAuthCallback,
    ));
  }
}

/// @nodoc
abstract class _$LoginMethodOAuthCopyWith<$Res>
    implements $LoginMethodCopyWith<$Res> {
  factory _$LoginMethodOAuthCopyWith(
          _LoginMethodOAuth value, $Res Function(_LoginMethodOAuth) then) =
      __$LoginMethodOAuthCopyWithImpl<$Res>;
  @override
  $Res call({OAuthCallback callback});
}

/// @nodoc
class __$LoginMethodOAuthCopyWithImpl<$Res>
    extends _$LoginMethodCopyWithImpl<$Res>
    implements _$LoginMethodOAuthCopyWith<$Res> {
  __$LoginMethodOAuthCopyWithImpl(
      _LoginMethodOAuth _value, $Res Function(_LoginMethodOAuth) _then)
      : super(_value, (v) => _then(v as _LoginMethodOAuth));

  @override
  _LoginMethodOAuth get _value => super._value as _LoginMethodOAuth;

  @override
  $Res call({
    Object? callback = freezed,
  }) {
    return _then(_LoginMethodOAuth(
      callback: callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as OAuthCallback,
    ));
  }
}

/// @nodoc

class _$_LoginMethodOAuth implements _LoginMethodOAuth {
  const _$_LoginMethodOAuth({required this.callback});

  @override

  /// The callback used for the auth process.
  final OAuthCallback callback;

  @override
  String toString() {
    return 'LoginMethod.oAuth(callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginMethodOAuth &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callback);

  @JsonKey(ignore: true)
  @override
  _$LoginMethodOAuthCopyWith<_LoginMethodOAuth> get copyWith =>
      __$LoginMethodOAuthCopyWithImpl<_LoginMethodOAuth>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OAuthCallback callback) oAuth,
  }) {
    return oAuth(callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OAuthCallback callback)? oAuth,
  }) {
    return oAuth?.call(callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OAuthCallback callback)? oAuth,
    required TResult orElse(),
  }) {
    if (oAuth != null) {
      return oAuth(callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginMethodOAuth value) oAuth,
  }) {
    return oAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginMethodOAuth value)? oAuth,
  }) {
    return oAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginMethodOAuth value)? oAuth,
    required TResult orElse(),
  }) {
    if (oAuth != null) {
      return oAuth(this);
    }
    return orElse();
  }
}

abstract class _LoginMethodOAuth implements LoginMethod {
  const factory _LoginMethodOAuth({required OAuthCallback callback}) =
      _$_LoginMethodOAuth;

  @override

  /// The callback used for the auth process.
  OAuthCallback get callback;
  @override
  @JsonKey(ignore: true)
  _$LoginMethodOAuthCopyWith<_LoginMethodOAuth> get copyWith =>
      throw _privateConstructorUsedError;
}
