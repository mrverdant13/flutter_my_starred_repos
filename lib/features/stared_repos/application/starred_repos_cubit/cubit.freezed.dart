// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StarredReposFailureTearOff {
  const _$StarredReposFailureTearOff();

  _StarredReposFailureOnRetrieve onRetrieve(GetStaredReposFailure failure) {
    return _StarredReposFailureOnRetrieve(
      failure,
    );
  }
}

/// @nodoc
const $StarredReposFailure = _$StarredReposFailureTearOff();

/// @nodoc
mixin _$StarredReposFailure {
  /// A starred repos retrieving failure.
  GetStaredReposFailure get failure => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetStaredReposFailure failure) onRetrieve,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetStaredReposFailure failure)? onRetrieve,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StarredReposFailureOnRetrieve value) onRetrieve,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposFailureOnRetrieve value)? onRetrieve,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StarredReposFailureCopyWith<StarredReposFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StarredReposFailureCopyWith<$Res> {
  factory $StarredReposFailureCopyWith(
          StarredReposFailure value, $Res Function(StarredReposFailure) then) =
      _$StarredReposFailureCopyWithImpl<$Res>;
  $Res call({GetStaredReposFailure failure});

  $GetStaredReposFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$StarredReposFailureCopyWithImpl<$Res>
    implements $StarredReposFailureCopyWith<$Res> {
  _$StarredReposFailureCopyWithImpl(this._value, this._then);

  final StarredReposFailure _value;
  // ignore: unused_field
  final $Res Function(StarredReposFailure) _then;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as GetStaredReposFailure,
    ));
  }

  @override
  $GetStaredReposFailureCopyWith<$Res> get failure {
    return $GetStaredReposFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc
abstract class _$StarredReposFailureOnRetrieveCopyWith<$Res>
    implements $StarredReposFailureCopyWith<$Res> {
  factory _$StarredReposFailureOnRetrieveCopyWith(
          _StarredReposFailureOnRetrieve value,
          $Res Function(_StarredReposFailureOnRetrieve) then) =
      __$StarredReposFailureOnRetrieveCopyWithImpl<$Res>;
  @override
  $Res call({GetStaredReposFailure failure});

  @override
  $GetStaredReposFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$StarredReposFailureOnRetrieveCopyWithImpl<$Res>
    extends _$StarredReposFailureCopyWithImpl<$Res>
    implements _$StarredReposFailureOnRetrieveCopyWith<$Res> {
  __$StarredReposFailureOnRetrieveCopyWithImpl(
      _StarredReposFailureOnRetrieve _value,
      $Res Function(_StarredReposFailureOnRetrieve) _then)
      : super(_value, (v) => _then(v as _StarredReposFailureOnRetrieve));

  @override
  _StarredReposFailureOnRetrieve get _value =>
      super._value as _StarredReposFailureOnRetrieve;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_StarredReposFailureOnRetrieve(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as GetStaredReposFailure,
    ));
  }
}

/// @nodoc

class _$_StarredReposFailureOnRetrieve
    implements _StarredReposFailureOnRetrieve {
  const _$_StarredReposFailureOnRetrieve(this.failure);

  @override

  /// A starred repos retrieving failure.
  final GetStaredReposFailure failure;

  @override
  String toString() {
    return 'StarredReposFailure.onRetrieve(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StarredReposFailureOnRetrieve &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$StarredReposFailureOnRetrieveCopyWith<_StarredReposFailureOnRetrieve>
      get copyWith => __$StarredReposFailureOnRetrieveCopyWithImpl<
          _StarredReposFailureOnRetrieve>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetStaredReposFailure failure) onRetrieve,
  }) {
    return onRetrieve(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetStaredReposFailure failure)? onRetrieve,
    required TResult orElse(),
  }) {
    if (onRetrieve != null) {
      return onRetrieve(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StarredReposFailureOnRetrieve value) onRetrieve,
  }) {
    return onRetrieve(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposFailureOnRetrieve value)? onRetrieve,
    required TResult orElse(),
  }) {
    if (onRetrieve != null) {
      return onRetrieve(this);
    }
    return orElse();
  }
}

abstract class _StarredReposFailureOnRetrieve implements StarredReposFailure {
  const factory _StarredReposFailureOnRetrieve(GetStaredReposFailure failure) =
      _$_StarredReposFailureOnRetrieve;

  @override

  /// A starred repos retrieving failure.
  GetStaredReposFailure get failure => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StarredReposFailureOnRetrieveCopyWith<_StarredReposFailureOnRetrieve>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$StarredReposStateTearOff {
  const _$StarredReposStateTearOff();

  _StarredReposStateLoading loading() {
    return const _StarredReposStateLoading();
  }

  _StarredReposStateLoaded loaded() {
    return const _StarredReposStateLoaded();
  }

  _StarredReposStateFailure failure(StarredReposFailure failure) {
    return _StarredReposStateFailure(
      failure,
    );
  }
}

/// @nodoc
const $StarredReposState = _$StarredReposStateTearOff();

/// @nodoc
mixin _$StarredReposState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(StarredReposFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(StarredReposFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StarredReposStateLoading value) loading,
    required TResult Function(_StarredReposStateLoaded value) loaded,
    required TResult Function(_StarredReposStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
    TResult Function(_StarredReposStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StarredReposStateCopyWith<$Res> {
  factory $StarredReposStateCopyWith(
          StarredReposState value, $Res Function(StarredReposState) then) =
      _$StarredReposStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$StarredReposStateCopyWithImpl<$Res>
    implements $StarredReposStateCopyWith<$Res> {
  _$StarredReposStateCopyWithImpl(this._value, this._then);

  final StarredReposState _value;
  // ignore: unused_field
  final $Res Function(StarredReposState) _then;
}

/// @nodoc
abstract class _$StarredReposStateLoadingCopyWith<$Res> {
  factory _$StarredReposStateLoadingCopyWith(_StarredReposStateLoading value,
          $Res Function(_StarredReposStateLoading) then) =
      __$StarredReposStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$StarredReposStateLoadingCopyWithImpl<$Res>
    extends _$StarredReposStateCopyWithImpl<$Res>
    implements _$StarredReposStateLoadingCopyWith<$Res> {
  __$StarredReposStateLoadingCopyWithImpl(_StarredReposStateLoading _value,
      $Res Function(_StarredReposStateLoading) _then)
      : super(_value, (v) => _then(v as _StarredReposStateLoading));

  @override
  _StarredReposStateLoading get _value =>
      super._value as _StarredReposStateLoading;
}

/// @nodoc

class _$_StarredReposStateLoading implements _StarredReposStateLoading {
  const _$_StarredReposStateLoading();

  @override
  String toString() {
    return 'StarredReposState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _StarredReposStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(StarredReposFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(StarredReposFailure failure)? failure,
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
    required TResult Function(_StarredReposStateLoading value) loading,
    required TResult Function(_StarredReposStateLoaded value) loaded,
    required TResult Function(_StarredReposStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
    TResult Function(_StarredReposStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _StarredReposStateLoading implements StarredReposState {
  const factory _StarredReposStateLoading() = _$_StarredReposStateLoading;
}

/// @nodoc
abstract class _$StarredReposStateLoadedCopyWith<$Res> {
  factory _$StarredReposStateLoadedCopyWith(_StarredReposStateLoaded value,
          $Res Function(_StarredReposStateLoaded) then) =
      __$StarredReposStateLoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$StarredReposStateLoadedCopyWithImpl<$Res>
    extends _$StarredReposStateCopyWithImpl<$Res>
    implements _$StarredReposStateLoadedCopyWith<$Res> {
  __$StarredReposStateLoadedCopyWithImpl(_StarredReposStateLoaded _value,
      $Res Function(_StarredReposStateLoaded) _then)
      : super(_value, (v) => _then(v as _StarredReposStateLoaded));

  @override
  _StarredReposStateLoaded get _value =>
      super._value as _StarredReposStateLoaded;
}

/// @nodoc

class _$_StarredReposStateLoaded implements _StarredReposStateLoaded {
  const _$_StarredReposStateLoaded();

  @override
  String toString() {
    return 'StarredReposState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _StarredReposStateLoaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(StarredReposFailure failure) failure,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(StarredReposFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StarredReposStateLoading value) loading,
    required TResult Function(_StarredReposStateLoaded value) loaded,
    required TResult Function(_StarredReposStateFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
    TResult Function(_StarredReposStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _StarredReposStateLoaded implements StarredReposState {
  const factory _StarredReposStateLoaded() = _$_StarredReposStateLoaded;
}

/// @nodoc
abstract class _$StarredReposStateFailureCopyWith<$Res> {
  factory _$StarredReposStateFailureCopyWith(_StarredReposStateFailure value,
          $Res Function(_StarredReposStateFailure) then) =
      __$StarredReposStateFailureCopyWithImpl<$Res>;
  $Res call({StarredReposFailure failure});

  $StarredReposFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$StarredReposStateFailureCopyWithImpl<$Res>
    extends _$StarredReposStateCopyWithImpl<$Res>
    implements _$StarredReposStateFailureCopyWith<$Res> {
  __$StarredReposStateFailureCopyWithImpl(_StarredReposStateFailure _value,
      $Res Function(_StarredReposStateFailure) _then)
      : super(_value, (v) => _then(v as _StarredReposStateFailure));

  @override
  _StarredReposStateFailure get _value =>
      super._value as _StarredReposStateFailure;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_StarredReposStateFailure(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as StarredReposFailure,
    ));
  }

  @override
  $StarredReposFailureCopyWith<$Res> get failure {
    return $StarredReposFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_StarredReposStateFailure implements _StarredReposStateFailure {
  const _$_StarredReposStateFailure(this.failure);

  @override
  final StarredReposFailure failure;

  @override
  String toString() {
    return 'StarredReposState.failure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StarredReposStateFailure &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$StarredReposStateFailureCopyWith<_StarredReposStateFailure> get copyWith =>
      __$StarredReposStateFailureCopyWithImpl<_StarredReposStateFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(StarredReposFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(StarredReposFailure failure)? failure,
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
    required TResult Function(_StarredReposStateLoading value) loading,
    required TResult Function(_StarredReposStateLoaded value) loaded,
    required TResult Function(_StarredReposStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
    TResult Function(_StarredReposStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _StarredReposStateFailure implements StarredReposState {
  const factory _StarredReposStateFailure(StarredReposFailure failure) =
      _$_StarredReposStateFailure;

  StarredReposFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$StarredReposStateFailureCopyWith<_StarredReposStateFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
