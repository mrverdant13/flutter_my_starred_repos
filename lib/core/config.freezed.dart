// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppConfigTearOff {
  const _$AppConfigTearOff();

  _AppConfig call(
      {@JsonKey(required: true, disallowNullValue: true)
          required GithubAuthConfig githubAuthConfig}) {
    return _AppConfig(
      githubAuthConfig: githubAuthConfig,
    );
  }
}

/// @nodoc
const $AppConfig = _$AppConfigTearOff();

/// @nodoc
mixin _$AppConfig {
  /// Holder of GitHub auth data.
  @JsonKey(required: true, disallowNullValue: true)
  GithubAuthConfig get githubAuthConfig => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppConfigCopyWith<AppConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigCopyWith<$Res> {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) then) =
      _$AppConfigCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(required: true, disallowNullValue: true)
          GithubAuthConfig githubAuthConfig});

  $GithubAuthConfigCopyWith<$Res> get githubAuthConfig;
}

/// @nodoc
class _$AppConfigCopyWithImpl<$Res> implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._value, this._then);

  final AppConfig _value;
  // ignore: unused_field
  final $Res Function(AppConfig) _then;

  @override
  $Res call({
    Object? githubAuthConfig = freezed,
  }) {
    return _then(_value.copyWith(
      githubAuthConfig: githubAuthConfig == freezed
          ? _value.githubAuthConfig
          : githubAuthConfig // ignore: cast_nullable_to_non_nullable
              as GithubAuthConfig,
    ));
  }

  @override
  $GithubAuthConfigCopyWith<$Res> get githubAuthConfig {
    return $GithubAuthConfigCopyWith<$Res>(_value.githubAuthConfig, (value) {
      return _then(_value.copyWith(githubAuthConfig: value));
    });
  }
}

/// @nodoc
abstract class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(
          _AppConfig value, $Res Function(_AppConfig) then) =
      __$AppConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(required: true, disallowNullValue: true)
          GithubAuthConfig githubAuthConfig});

  @override
  $GithubAuthConfigCopyWith<$Res> get githubAuthConfig;
}

/// @nodoc
class __$AppConfigCopyWithImpl<$Res> extends _$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(_AppConfig _value, $Res Function(_AppConfig) _then)
      : super(_value, (v) => _then(v as _AppConfig));

  @override
  _AppConfig get _value => super._value as _AppConfig;

  @override
  $Res call({
    Object? githubAuthConfig = freezed,
  }) {
    return _then(_AppConfig(
      githubAuthConfig: githubAuthConfig == freezed
          ? _value.githubAuthConfig
          : githubAuthConfig // ignore: cast_nullable_to_non_nullable
              as GithubAuthConfig,
    ));
  }
}

/// @nodoc

@visibleForTesting
@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class _$_AppConfig implements _AppConfig {
  const _$_AppConfig(
      {@JsonKey(required: true, disallowNullValue: true)
          required this.githubAuthConfig});

  @override

  /// Holder of GitHub auth data.
  @JsonKey(required: true, disallowNullValue: true)
  final GithubAuthConfig githubAuthConfig;

  @override
  String toString() {
    return 'AppConfig(githubAuthConfig: $githubAuthConfig)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppConfig &&
            (identical(other.githubAuthConfig, githubAuthConfig) ||
                const DeepCollectionEquality()
                    .equals(other.githubAuthConfig, githubAuthConfig)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(githubAuthConfig);

  @JsonKey(ignore: true)
  @override
  _$AppConfigCopyWith<_AppConfig> get copyWith =>
      __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);
}

abstract class _AppConfig implements AppConfig {
  const factory _AppConfig(
      {@JsonKey(required: true, disallowNullValue: true)
          required GithubAuthConfig githubAuthConfig}) = _$_AppConfig;

  @override

  /// Holder of GitHub auth data.
  @JsonKey(required: true, disallowNullValue: true)
  GithubAuthConfig get githubAuthConfig => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppConfigCopyWith<_AppConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

GithubAuthConfig _$GithubAuthConfigFromJson(Map<String, dynamic> json) {
  return _GithubAuthConfig.fromJson(json);
}

/// @nodoc
class _$GithubAuthConfigTearOff {
  const _$GithubAuthConfigTearOff();

  _GithubAuthConfig call(
      {@JsonKey(required: true, disallowNullValue: true)
          required String clientId,
      @JsonKey(required: true, disallowNullValue: true)
          required String clientSecret}) {
    return _GithubAuthConfig(
      clientId: clientId,
      clientSecret: clientSecret,
    );
  }

  GithubAuthConfig fromJson(Map<String, Object> json) {
    return GithubAuthConfig.fromJson(json);
  }
}

/// @nodoc
const $GithubAuthConfig = _$GithubAuthConfigTearOff();

/// @nodoc
mixin _$GithubAuthConfig {
  /// GitHub client ID.
  @JsonKey(required: true, disallowNullValue: true)
  String get clientId => throw _privateConstructorUsedError;

  /// GitHub client secret.
  @JsonKey(required: true, disallowNullValue: true)
  String get clientSecret => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GithubAuthConfigCopyWith<GithubAuthConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubAuthConfigCopyWith<$Res> {
  factory $GithubAuthConfigCopyWith(
          GithubAuthConfig value, $Res Function(GithubAuthConfig) then) =
      _$GithubAuthConfigCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(required: true, disallowNullValue: true) String clientId,
      @JsonKey(required: true, disallowNullValue: true) String clientSecret});
}

/// @nodoc
class _$GithubAuthConfigCopyWithImpl<$Res>
    implements $GithubAuthConfigCopyWith<$Res> {
  _$GithubAuthConfigCopyWithImpl(this._value, this._then);

  final GithubAuthConfig _value;
  // ignore: unused_field
  final $Res Function(GithubAuthConfig) _then;

  @override
  $Res call({
    Object? clientId = freezed,
    Object? clientSecret = freezed,
  }) {
    return _then(_value.copyWith(
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: clientSecret == freezed
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$GithubAuthConfigCopyWith<$Res>
    implements $GithubAuthConfigCopyWith<$Res> {
  factory _$GithubAuthConfigCopyWith(
          _GithubAuthConfig value, $Res Function(_GithubAuthConfig) then) =
      __$GithubAuthConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(required: true, disallowNullValue: true) String clientId,
      @JsonKey(required: true, disallowNullValue: true) String clientSecret});
}

/// @nodoc
class __$GithubAuthConfigCopyWithImpl<$Res>
    extends _$GithubAuthConfigCopyWithImpl<$Res>
    implements _$GithubAuthConfigCopyWith<$Res> {
  __$GithubAuthConfigCopyWithImpl(
      _GithubAuthConfig _value, $Res Function(_GithubAuthConfig) _then)
      : super(_value, (v) => _then(v as _GithubAuthConfig));

  @override
  _GithubAuthConfig get _value => super._value as _GithubAuthConfig;

  @override
  $Res call({
    Object? clientId = freezed,
    Object? clientSecret = freezed,
  }) {
    return _then(_GithubAuthConfig(
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: clientSecret == freezed
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@visibleForTesting
@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class _$_GithubAuthConfig implements _GithubAuthConfig {
  const _$_GithubAuthConfig(
      {@JsonKey(required: true, disallowNullValue: true)
          required this.clientId,
      @JsonKey(required: true, disallowNullValue: true)
          required this.clientSecret});

  factory _$_GithubAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$_$_GithubAuthConfigFromJson(json);

  @override

  /// GitHub client ID.
  @JsonKey(required: true, disallowNullValue: true)
  final String clientId;
  @override

  /// GitHub client secret.
  @JsonKey(required: true, disallowNullValue: true)
  final String clientSecret;

  @override
  String toString() {
    return 'GithubAuthConfig(clientId: $clientId, clientSecret: $clientSecret)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GithubAuthConfig &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality()
                    .equals(other.clientSecret, clientSecret)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(clientSecret);

  @JsonKey(ignore: true)
  @override
  _$GithubAuthConfigCopyWith<_GithubAuthConfig> get copyWith =>
      __$GithubAuthConfigCopyWithImpl<_GithubAuthConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GithubAuthConfigToJson(this);
  }
}

abstract class _GithubAuthConfig implements GithubAuthConfig {
  const factory _GithubAuthConfig(
      {@JsonKey(required: true, disallowNullValue: true)
          required String clientId,
      @JsonKey(required: true, disallowNullValue: true)
          required String clientSecret}) = _$_GithubAuthConfig;

  factory _GithubAuthConfig.fromJson(Map<String, dynamic> json) =
      _$_GithubAuthConfig.fromJson;

  @override

  /// GitHub client ID.
  @JsonKey(required: true, disallowNullValue: true)
  String get clientId => throw _privateConstructorUsedError;
  @override

  /// GitHub client secret.
  @JsonKey(required: true, disallowNullValue: true)
  String get clientSecret => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GithubAuthConfigCopyWith<_GithubAuthConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
