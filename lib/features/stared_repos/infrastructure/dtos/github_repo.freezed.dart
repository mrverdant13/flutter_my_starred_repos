// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'github_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GithubRepoDto _$GithubRepoDtoFromJson(Map<String, dynamic> json) {
  return _GithubRepoDto.fromJson(json);
}

/// @nodoc
class _$GithubRepoDtoTearOff {
  const _$GithubRepoDtoTearOff();

  _GithubRepoDto call(
      {required UserDto owner,
      required String name,
      @JsonKey(defaultValue: '') required String description,
      @JsonKey(name: 'stargazers_count') required int starsCount}) {
    return _GithubRepoDto(
      owner: owner,
      name: name,
      description: description,
      starsCount: starsCount,
    );
  }

  GithubRepoDto fromJson(Map<String, Object?> json) {
    return GithubRepoDto.fromJson(json);
  }
}

/// @nodoc
const $GithubRepoDto = _$GithubRepoDtoTearOff();

/// @nodoc
mixin _$GithubRepoDto {
  /// The GitHub user that owns this repository.
  UserDto get owner => throw _privateConstructorUsedError;

  /// The name of this repository.
  String get name => throw _privateConstructorUsedError;

  /// The description of this repository.
  ///
  /// The description could be empty.
// ignore: invalid_annotation_target
  @JsonKey(defaultValue: '')
  String get description => throw _privateConstructorUsedError;

  /// The amount of starts of this repository.
// ignore: invalid_annotation_target
  @JsonKey(name: 'stargazers_count')
  int get starsCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GithubRepoDtoCopyWith<GithubRepoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubRepoDtoCopyWith<$Res> {
  factory $GithubRepoDtoCopyWith(
          GithubRepoDto value, $Res Function(GithubRepoDto) then) =
      _$GithubRepoDtoCopyWithImpl<$Res>;
  $Res call(
      {UserDto owner,
      String name,
      @JsonKey(defaultValue: '') String description,
      @JsonKey(name: 'stargazers_count') int starsCount});

  $UserDtoCopyWith<$Res> get owner;
}

/// @nodoc
class _$GithubRepoDtoCopyWithImpl<$Res>
    implements $GithubRepoDtoCopyWith<$Res> {
  _$GithubRepoDtoCopyWithImpl(this._value, this._then);

  final GithubRepoDto _value;
  // ignore: unused_field
  final $Res Function(GithubRepoDto) _then;

  @override
  $Res call({
    Object? owner = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? starsCount = freezed,
  }) {
    return _then(_value.copyWith(
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as UserDto,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      starsCount: starsCount == freezed
          ? _value.starsCount
          : starsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $UserDtoCopyWith<$Res> get owner {
    return $UserDtoCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value));
    });
  }
}

/// @nodoc
abstract class _$GithubRepoDtoCopyWith<$Res>
    implements $GithubRepoDtoCopyWith<$Res> {
  factory _$GithubRepoDtoCopyWith(
          _GithubRepoDto value, $Res Function(_GithubRepoDto) then) =
      __$GithubRepoDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {UserDto owner,
      String name,
      @JsonKey(defaultValue: '') String description,
      @JsonKey(name: 'stargazers_count') int starsCount});

  @override
  $UserDtoCopyWith<$Res> get owner;
}

/// @nodoc
class __$GithubRepoDtoCopyWithImpl<$Res>
    extends _$GithubRepoDtoCopyWithImpl<$Res>
    implements _$GithubRepoDtoCopyWith<$Res> {
  __$GithubRepoDtoCopyWithImpl(
      _GithubRepoDto _value, $Res Function(_GithubRepoDto) _then)
      : super(_value, (v) => _then(v as _GithubRepoDto));

  @override
  _GithubRepoDto get _value => super._value as _GithubRepoDto;

  @override
  $Res call({
    Object? owner = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? starsCount = freezed,
  }) {
    return _then(_GithubRepoDto(
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as UserDto,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      starsCount: starsCount == freezed
          ? _value.starsCount
          : starsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_GithubRepoDto implements _GithubRepoDto {
  const _$_GithubRepoDto(
      {required this.owner,
      required this.name,
      @JsonKey(defaultValue: '') required this.description,
      @JsonKey(name: 'stargazers_count') required this.starsCount});

  factory _$_GithubRepoDto.fromJson(Map<String, dynamic> json) =>
      _$$_GithubRepoDtoFromJson(json);

  @override

  /// The GitHub user that owns this repository.
  final UserDto owner;
  @override

  /// The name of this repository.
  final String name;
  @override

  /// The description of this repository.
  ///
  /// The description could be empty.
// ignore: invalid_annotation_target
  @JsonKey(defaultValue: '')
  final String description;
  @override

  /// The amount of starts of this repository.
// ignore: invalid_annotation_target
  @JsonKey(name: 'stargazers_count')
  final int starsCount;

  @override
  String toString() {
    return 'GithubRepoDto(owner: $owner, name: $name, description: $description, starsCount: $starsCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GithubRepoDto &&
            const DeepCollectionEquality().equals(other.owner, owner) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.starsCount, starsCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(owner),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(starsCount));

  @JsonKey(ignore: true)
  @override
  _$GithubRepoDtoCopyWith<_GithubRepoDto> get copyWith =>
      __$GithubRepoDtoCopyWithImpl<_GithubRepoDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GithubRepoDtoToJson(this);
  }
}

abstract class _GithubRepoDto implements GithubRepoDto {
  const factory _GithubRepoDto(
          {required UserDto owner,
          required String name,
          @JsonKey(defaultValue: '') required String description,
          @JsonKey(name: 'stargazers_count') required int starsCount}) =
      _$_GithubRepoDto;

  factory _GithubRepoDto.fromJson(Map<String, dynamic> json) =
      _$_GithubRepoDto.fromJson;

  @override

  /// The GitHub user that owns this repository.
  UserDto get owner;
  @override

  /// The name of this repository.
  String get name;
  @override

  /// The description of this repository.
  ///
  /// The description could be empty.
// ignore: invalid_annotation_target
  @JsonKey(defaultValue: '')
  String get description;
  @override

  /// The amount of starts of this repository.
// ignore: invalid_annotation_target
  @JsonKey(name: 'stargazers_count')
  int get starsCount;
  @override
  @JsonKey(ignore: true)
  _$GithubRepoDtoCopyWith<_GithubRepoDto> get copyWith =>
      throw _privateConstructorUsedError;
}
