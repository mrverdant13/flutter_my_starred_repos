// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'github_auth_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

  GithubAuthConfig fromJson(Map<String, Object?> json) {
    return GithubAuthConfig.fromJson(json);
  }
}

/// @nodoc
const $GithubAuthConfig = _$GithubAuthConfigTearOff();

/// @nodoc
mixin _$GithubAuthConfig {
// ignore: invalid_annotation_target
  @JsonKey(required: true, disallowNullValue: true)
  String get clientId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
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
      _$$_GithubAuthConfigFromJson(json);

  @override // ignore: invalid_annotation_target
  @JsonKey(required: true, disallowNullValue: true)
  final String clientId;
  @override // ignore: invalid_annotation_target
  @JsonKey(required: true, disallowNullValue: true)
  final String clientSecret;

  @override
  String toString() {
    return 'GithubAuthConfig(clientId: $clientId, clientSecret: $clientSecret)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GithubAuthConfig &&
            const DeepCollectionEquality().equals(other.clientId, clientId) &&
            const DeepCollectionEquality()
                .equals(other.clientSecret, clientSecret));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(clientId),
      const DeepCollectionEquality().hash(clientSecret));

  @JsonKey(ignore: true)
  @override
  _$GithubAuthConfigCopyWith<_GithubAuthConfig> get copyWith =>
      __$GithubAuthConfigCopyWithImpl<_GithubAuthConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GithubAuthConfigToJson(this);
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

  @override // ignore: invalid_annotation_target
  @JsonKey(required: true, disallowNullValue: true)
  String get clientId;
  @override // ignore: invalid_annotation_target
  @JsonKey(required: true, disallowNullValue: true)
  String get clientSecret;
  @override
  @JsonKey(ignore: true)
  _$GithubAuthConfigCopyWith<_GithubAuthConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
