// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth.cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthFailureTearOff {
  const _$AuthFailureTearOff();

  _AuthFailureLogIn logIn(LoginFailure failure) {
    return _AuthFailureLogIn(
      failure,
    );
  }
}

/// @nodoc
const $AuthFailure = _$AuthFailureTearOff();

/// @nodoc
mixin _$AuthFailure {
  LoginFailure get failure => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFailure failure) logIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(LoginFailure failure)? logIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginFailure failure)? logIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthFailureLogIn value) logIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthFailureLogIn value)? logIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthFailureLogIn value)? logIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthFailureCopyWith<AuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res>;
  $Res call({LoginFailure failure});

  $LoginFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res> implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  final AuthFailure _value;
  // ignore: unused_field
  final $Res Function(AuthFailure) _then;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as LoginFailure,
    ));
  }

  @override
  $LoginFailureCopyWith<$Res> get failure {
    return $LoginFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc
abstract class _$AuthFailureLogInCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$AuthFailureLogInCopyWith(
          _AuthFailureLogIn value, $Res Function(_AuthFailureLogIn) then) =
      __$AuthFailureLogInCopyWithImpl<$Res>;
  @override
  $Res call({LoginFailure failure});

  @override
  $LoginFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$AuthFailureLogInCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res>
    implements _$AuthFailureLogInCopyWith<$Res> {
  __$AuthFailureLogInCopyWithImpl(
      _AuthFailureLogIn _value, $Res Function(_AuthFailureLogIn) _then)
      : super(_value, (v) => _then(v as _AuthFailureLogIn));

  @override
  _AuthFailureLogIn get _value => super._value as _AuthFailureLogIn;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_AuthFailureLogIn(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as LoginFailure,
    ));
  }
}

/// @nodoc

class _$_AuthFailureLogIn implements _AuthFailureLogIn {
  const _$_AuthFailureLogIn(this.failure);

  @override
  final LoginFailure failure;

  @override
  String toString() {
    return 'AuthFailure.logIn(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthFailureLogIn &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$AuthFailureLogInCopyWith<_AuthFailureLogIn> get copyWith =>
      __$AuthFailureLogInCopyWithImpl<_AuthFailureLogIn>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFailure failure) logIn,
  }) {
    return logIn(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(LoginFailure failure)? logIn,
  }) {
    return logIn?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginFailure failure)? logIn,
    required TResult orElse(),
  }) {
    if (logIn != null) {
      return logIn(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthFailureLogIn value) logIn,
  }) {
    return logIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthFailureLogIn value)? logIn,
  }) {
    return logIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthFailureLogIn value)? logIn,
    required TResult orElse(),
  }) {
    if (logIn != null) {
      return logIn(this);
    }
    return orElse();
  }
}

abstract class _AuthFailureLogIn implements AuthFailure {
  const factory _AuthFailureLogIn(LoginFailure failure) = _$_AuthFailureLogIn;

  @override
  LoginFailure get failure;
  @override
  @JsonKey(ignore: true)
  _$AuthFailureLogInCopyWith<_AuthFailureLogIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  _AuthStateLoading loading({required bool isLoggedIn}) {
    return _AuthStateLoading(
      isLoggedIn: isLoggedIn,
    );
  }

  _AuthStateLoaded loaded({required bool isLoggedIn}) {
    return _AuthStateLoaded(
      isLoggedIn: isLoggedIn,
    );
  }

  _AuthStateFailure failure(
      {required bool isLoggedIn, required AuthFailure failure}) {
    return _AuthStateFailure(
      isLoggedIn: isLoggedIn,
      failure: failure,
    );
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  bool get isLoggedIn => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoggedIn) loading,
    required TResult Function(bool isLoggedIn) loaded,
    required TResult Function(bool isLoggedIn, AuthFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
  $Res call({bool isLoggedIn});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;

  @override
  $Res call({
    Object? isLoggedIn = freezed,
  }) {
    return _then(_value.copyWith(
      isLoggedIn: isLoggedIn == freezed
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$AuthStateLoadingCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateLoadingCopyWith(
          _AuthStateLoading value, $Res Function(_AuthStateLoading) then) =
      __$AuthStateLoadingCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoggedIn});
}

/// @nodoc
class __$AuthStateLoadingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateLoadingCopyWith<$Res> {
  __$AuthStateLoadingCopyWithImpl(
      _AuthStateLoading _value, $Res Function(_AuthStateLoading) _then)
      : super(_value, (v) => _then(v as _AuthStateLoading));

  @override
  _AuthStateLoading get _value => super._value as _AuthStateLoading;

  @override
  $Res call({
    Object? isLoggedIn = freezed,
  }) {
    return _then(_AuthStateLoading(
      isLoggedIn: isLoggedIn == freezed
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AuthStateLoading implements _AuthStateLoading {
  const _$_AuthStateLoading({required this.isLoggedIn});

  @override
  final bool isLoggedIn;

  @override
  String toString() {
    return 'AuthState.loading(isLoggedIn: $isLoggedIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthStateLoading &&
            const DeepCollectionEquality()
                .equals(other.isLoggedIn, isLoggedIn));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(isLoggedIn));

  @JsonKey(ignore: true)
  @override
  _$AuthStateLoadingCopyWith<_AuthStateLoading> get copyWith =>
      __$AuthStateLoadingCopyWithImpl<_AuthStateLoading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoggedIn) loading,
    required TResult Function(bool isLoggedIn) loaded,
    required TResult Function(bool isLoggedIn, AuthFailure failure) failure,
  }) {
    return loading(isLoggedIn);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
  }) {
    return loading?.call(isLoggedIn);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(isLoggedIn);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AuthStateLoading implements AuthState {
  const factory _AuthStateLoading({required bool isLoggedIn}) =
      _$_AuthStateLoading;

  @override
  bool get isLoggedIn;
  @override
  @JsonKey(ignore: true)
  _$AuthStateLoadingCopyWith<_AuthStateLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthStateLoadedCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateLoadedCopyWith(
          _AuthStateLoaded value, $Res Function(_AuthStateLoaded) then) =
      __$AuthStateLoadedCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoggedIn});
}

/// @nodoc
class __$AuthStateLoadedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateLoadedCopyWith<$Res> {
  __$AuthStateLoadedCopyWithImpl(
      _AuthStateLoaded _value, $Res Function(_AuthStateLoaded) _then)
      : super(_value, (v) => _then(v as _AuthStateLoaded));

  @override
  _AuthStateLoaded get _value => super._value as _AuthStateLoaded;

  @override
  $Res call({
    Object? isLoggedIn = freezed,
  }) {
    return _then(_AuthStateLoaded(
      isLoggedIn: isLoggedIn == freezed
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AuthStateLoaded implements _AuthStateLoaded {
  const _$_AuthStateLoaded({required this.isLoggedIn});

  @override
  final bool isLoggedIn;

  @override
  String toString() {
    return 'AuthState.loaded(isLoggedIn: $isLoggedIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthStateLoaded &&
            const DeepCollectionEquality()
                .equals(other.isLoggedIn, isLoggedIn));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(isLoggedIn));

  @JsonKey(ignore: true)
  @override
  _$AuthStateLoadedCopyWith<_AuthStateLoaded> get copyWith =>
      __$AuthStateLoadedCopyWithImpl<_AuthStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoggedIn) loading,
    required TResult Function(bool isLoggedIn) loaded,
    required TResult Function(bool isLoggedIn, AuthFailure failure) failure,
  }) {
    return loaded(isLoggedIn);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
  }) {
    return loaded?.call(isLoggedIn);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(isLoggedIn);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _AuthStateLoaded implements AuthState {
  const factory _AuthStateLoaded({required bool isLoggedIn}) =
      _$_AuthStateLoaded;

  @override
  bool get isLoggedIn;
  @override
  @JsonKey(ignore: true)
  _$AuthStateLoadedCopyWith<_AuthStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthStateFailureCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateFailureCopyWith(
          _AuthStateFailure value, $Res Function(_AuthStateFailure) then) =
      __$AuthStateFailureCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoggedIn, AuthFailure failure});

  $AuthFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$AuthStateFailureCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateFailureCopyWith<$Res> {
  __$AuthStateFailureCopyWithImpl(
      _AuthStateFailure _value, $Res Function(_AuthStateFailure) _then)
      : super(_value, (v) => _then(v as _AuthStateFailure));

  @override
  _AuthStateFailure get _value => super._value as _AuthStateFailure;

  @override
  $Res call({
    Object? isLoggedIn = freezed,
    Object? failure = freezed,
  }) {
    return _then(_AuthStateFailure(
      isLoggedIn: isLoggedIn == freezed
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AuthFailure,
    ));
  }

  @override
  $AuthFailureCopyWith<$Res> get failure {
    return $AuthFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_AuthStateFailure implements _AuthStateFailure {
  const _$_AuthStateFailure({required this.isLoggedIn, required this.failure});

  @override
  final bool isLoggedIn;
  @override
  final AuthFailure failure;

  @override
  String toString() {
    return 'AuthState.failure(isLoggedIn: $isLoggedIn, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthStateFailure &&
            const DeepCollectionEquality()
                .equals(other.isLoggedIn, isLoggedIn) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoggedIn),
      const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$AuthStateFailureCopyWith<_AuthStateFailure> get copyWith =>
      __$AuthStateFailureCopyWithImpl<_AuthStateFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoggedIn) loading,
    required TResult Function(bool isLoggedIn) loaded,
    required TResult Function(bool isLoggedIn, AuthFailure failure) failure,
  }) {
    return failure(isLoggedIn, this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
  }) {
    return failure?.call(isLoggedIn, this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoggedIn)? loading,
    TResult Function(bool isLoggedIn)? loaded,
    TResult Function(bool isLoggedIn, AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(isLoggedIn, this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateLoading value) loading,
    required TResult Function(_AuthStateLoaded value) loaded,
    required TResult Function(_AuthStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateLoading value)? loading,
    TResult Function(_AuthStateLoaded value)? loaded,
    TResult Function(_AuthStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _AuthStateFailure implements AuthState {
  const factory _AuthStateFailure(
      {required bool isLoggedIn,
      required AuthFailure failure}) = _$_AuthStateFailure;

  @override
  bool get isLoggedIn;
  AuthFailure get failure;
  @override
  @JsonKey(ignore: true)
  _$AuthStateFailureCopyWith<_AuthStateFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
