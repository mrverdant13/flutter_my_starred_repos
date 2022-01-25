// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile.cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProfileStateTearOff {
  const _$ProfileStateTearOff();

  _ProfileStateLoading loading() {
    return const _ProfileStateLoading();
  }

  _ProfileStateLoaded loaded({required Profile profile}) {
    return _ProfileStateLoaded(
      profile: profile,
    );
  }

  _ProfileStateFailure failure({required GetProfileFailure failure}) {
    return _ProfileStateFailure(
      failure: failure,
    );
  }
}

/// @nodoc
const $ProfileState = _$ProfileStateTearOff();

/// @nodoc
mixin _$ProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Profile profile) loaded,
    required TResult Function(GetProfileFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res> implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  final ProfileState _value;
  // ignore: unused_field
  final $Res Function(ProfileState) _then;
}

/// @nodoc
abstract class _$ProfileStateLoadingCopyWith<$Res> {
  factory _$ProfileStateLoadingCopyWith(_ProfileStateLoading value,
          $Res Function(_ProfileStateLoading) then) =
      __$ProfileStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$ProfileStateLoadingCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateLoadingCopyWith<$Res> {
  __$ProfileStateLoadingCopyWithImpl(
      _ProfileStateLoading _value, $Res Function(_ProfileStateLoading) _then)
      : super(_value, (v) => _then(v as _ProfileStateLoading));

  @override
  _ProfileStateLoading get _value => super._value as _ProfileStateLoading;
}

/// @nodoc

class _$_ProfileStateLoading implements _ProfileStateLoading {
  const _$_ProfileStateLoading();

  @override
  String toString() {
    return 'ProfileState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ProfileStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Profile profile) loaded,
    required TResult Function(GetProfileFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ProfileStateLoading implements ProfileState {
  const factory _ProfileStateLoading() = _$_ProfileStateLoading;
}

/// @nodoc
abstract class _$ProfileStateLoadedCopyWith<$Res> {
  factory _$ProfileStateLoadedCopyWith(
          _ProfileStateLoaded value, $Res Function(_ProfileStateLoaded) then) =
      __$ProfileStateLoadedCopyWithImpl<$Res>;
  $Res call({Profile profile});

  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$ProfileStateLoadedCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateLoadedCopyWith<$Res> {
  __$ProfileStateLoadedCopyWithImpl(
      _ProfileStateLoaded _value, $Res Function(_ProfileStateLoaded) _then)
      : super(_value, (v) => _then(v as _ProfileStateLoaded));

  @override
  _ProfileStateLoaded get _value => super._value as _ProfileStateLoaded;

  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(_ProfileStateLoaded(
      profile: profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }

  @override
  $ProfileCopyWith<$Res> get profile {
    return $ProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$_ProfileStateLoaded implements _ProfileStateLoaded {
  const _$_ProfileStateLoaded({required this.profile});

  @override
  final Profile profile;

  @override
  String toString() {
    return 'ProfileState.loaded(profile: $profile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfileStateLoaded &&
            const DeepCollectionEquality().equals(other.profile, profile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(profile));

  @JsonKey(ignore: true)
  @override
  _$ProfileStateLoadedCopyWith<_ProfileStateLoaded> get copyWith =>
      __$ProfileStateLoadedCopyWithImpl<_ProfileStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Profile profile) loaded,
    required TResult Function(GetProfileFailure failure) failure,
  }) {
    return loaded(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
  }) {
    return loaded?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _ProfileStateLoaded implements ProfileState {
  const factory _ProfileStateLoaded({required Profile profile}) =
      _$_ProfileStateLoaded;

  Profile get profile;
  @JsonKey(ignore: true)
  _$ProfileStateLoadedCopyWith<_ProfileStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ProfileStateFailureCopyWith<$Res> {
  factory _$ProfileStateFailureCopyWith(_ProfileStateFailure value,
          $Res Function(_ProfileStateFailure) then) =
      __$ProfileStateFailureCopyWithImpl<$Res>;
  $Res call({GetProfileFailure failure});

  $GetProfileFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$ProfileStateFailureCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateFailureCopyWith<$Res> {
  __$ProfileStateFailureCopyWithImpl(
      _ProfileStateFailure _value, $Res Function(_ProfileStateFailure) _then)
      : super(_value, (v) => _then(v as _ProfileStateFailure));

  @override
  _ProfileStateFailure get _value => super._value as _ProfileStateFailure;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_ProfileStateFailure(
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as GetProfileFailure,
    ));
  }

  @override
  $GetProfileFailureCopyWith<$Res> get failure {
    return $GetProfileFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_ProfileStateFailure implements _ProfileStateFailure {
  const _$_ProfileStateFailure({required this.failure});

  @override
  final GetProfileFailure failure;

  @override
  String toString() {
    return 'ProfileState.failure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfileStateFailure &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$ProfileStateFailureCopyWith<_ProfileStateFailure> get copyWith =>
      __$ProfileStateFailureCopyWithImpl<_ProfileStateFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Profile profile) loaded,
    required TResult Function(GetProfileFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Profile profile)? loaded,
    TResult Function(GetProfileFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _ProfileStateFailure implements ProfileState {
  const factory _ProfileStateFailure({required GetProfileFailure failure}) =
      _$_ProfileStateFailure;

  GetProfileFailure get failure;
  @JsonKey(ignore: true)
  _$ProfileStateFailureCopyWith<_ProfileStateFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
