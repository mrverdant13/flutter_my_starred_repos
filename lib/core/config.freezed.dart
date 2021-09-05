// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
