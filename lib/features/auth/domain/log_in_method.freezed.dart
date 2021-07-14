// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'log_in_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LogInMethodTearOff {
  const _$LogInMethodTearOff();

  _LogInMethodOAuth oAuth(
      {required Future<Uri?> Function(
              {required Uri authorizationEndpoint,
              required Uri redirectBaseEndpoint})
          callback}) {
    return _LogInMethodOAuth(
      callback: callback,
    );
  }
}

/// @nodoc
const $LogInMethod = _$LogInMethodTearOff();

/// @nodoc
mixin _$LogInMethod {
  /// The callback used for the auth process.
  Future<Uri?> Function(
          {required Uri authorizationEndpoint,
          required Uri redirectBaseEndpoint})
      get callback => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Future<Uri?> Function(
                    {required Uri authorizationEndpoint,
                    required Uri redirectBaseEndpoint})
                callback)
        oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Future<Uri?> Function(
                    {required Uri authorizationEndpoint,
                    required Uri redirectBaseEndpoint})
                callback)?
        oAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LogInMethodOAuth value) oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LogInMethodOAuth value)? oAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LogInMethodCopyWith<LogInMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogInMethodCopyWith<$Res> {
  factory $LogInMethodCopyWith(
          LogInMethod value, $Res Function(LogInMethod) then) =
      _$LogInMethodCopyWithImpl<$Res>;
  $Res call(
      {Future<Uri?> Function(
              {required Uri authorizationEndpoint,
              required Uri redirectBaseEndpoint})
          callback});
}

/// @nodoc
class _$LogInMethodCopyWithImpl<$Res> implements $LogInMethodCopyWith<$Res> {
  _$LogInMethodCopyWithImpl(this._value, this._then);

  final LogInMethod _value;
  // ignore: unused_field
  final $Res Function(LogInMethod) _then;

  @override
  $Res call({
    Object? callback = freezed,
  }) {
    return _then(_value.copyWith(
      callback: callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as Future<Uri?> Function(
                  {required Uri authorizationEndpoint,
                  required Uri redirectBaseEndpoint}),
    ));
  }
}

/// @nodoc
abstract class _$LogInMethodOAuthCopyWith<$Res>
    implements $LogInMethodCopyWith<$Res> {
  factory _$LogInMethodOAuthCopyWith(
          _LogInMethodOAuth value, $Res Function(_LogInMethodOAuth) then) =
      __$LogInMethodOAuthCopyWithImpl<$Res>;
  @override
  $Res call(
      {Future<Uri?> Function(
              {required Uri authorizationEndpoint,
              required Uri redirectBaseEndpoint})
          callback});
}

/// @nodoc
class __$LogInMethodOAuthCopyWithImpl<$Res>
    extends _$LogInMethodCopyWithImpl<$Res>
    implements _$LogInMethodOAuthCopyWith<$Res> {
  __$LogInMethodOAuthCopyWithImpl(
      _LogInMethodOAuth _value, $Res Function(_LogInMethodOAuth) _then)
      : super(_value, (v) => _then(v as _LogInMethodOAuth));

  @override
  _LogInMethodOAuth get _value => super._value as _LogInMethodOAuth;

  @override
  $Res call({
    Object? callback = freezed,
  }) {
    return _then(_LogInMethodOAuth(
      callback: callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as Future<Uri?> Function(
                  {required Uri authorizationEndpoint,
                  required Uri redirectBaseEndpoint}),
    ));
  }
}

/// @nodoc

class _$_LogInMethodOAuth implements _LogInMethodOAuth {
  const _$_LogInMethodOAuth({required this.callback});

  @override

  /// The callback used for the auth process.
  final Future<Uri?> Function(
      {required Uri authorizationEndpoint,
      required Uri redirectBaseEndpoint}) callback;

  @override
  String toString() {
    return 'LogInMethod.oAuth(callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LogInMethodOAuth &&
            (identical(other.callback, callback) ||
                const DeepCollectionEquality()
                    .equals(other.callback, callback)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(callback);

  @JsonKey(ignore: true)
  @override
  _$LogInMethodOAuthCopyWith<_LogInMethodOAuth> get copyWith =>
      __$LogInMethodOAuthCopyWithImpl<_LogInMethodOAuth>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Future<Uri?> Function(
                    {required Uri authorizationEndpoint,
                    required Uri redirectBaseEndpoint})
                callback)
        oAuth,
  }) {
    return oAuth(callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Future<Uri?> Function(
                    {required Uri authorizationEndpoint,
                    required Uri redirectBaseEndpoint})
                callback)?
        oAuth,
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
    required TResult Function(_LogInMethodOAuth value) oAuth,
  }) {
    return oAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LogInMethodOAuth value)? oAuth,
    required TResult orElse(),
  }) {
    if (oAuth != null) {
      return oAuth(this);
    }
    return orElse();
  }
}

abstract class _LogInMethodOAuth implements LogInMethod {
  const factory _LogInMethodOAuth(
      {required Future<Uri?> Function(
              {required Uri authorizationEndpoint,
              required Uri redirectBaseEndpoint})
          callback}) = _$_LogInMethodOAuth;

  @override

  /// The callback used for the auth process.
  Future<Uri?> Function(
          {required Uri authorizationEndpoint,
          required Uri redirectBaseEndpoint})
      get callback => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LogInMethodOAuthCopyWith<_LogInMethodOAuth> get copyWith =>
      throw _privateConstructorUsedError;
}
