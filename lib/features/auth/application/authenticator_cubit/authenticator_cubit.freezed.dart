// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'authenticator_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthenticatorFailureTearOff {
  const _$AuthenticatorFailureTearOff();

  _AuthenticatorFailureLogIn logIn(LoginFailure failure) {
    return _AuthenticatorFailureLogIn(
      failure,
    );
  }
}

/// @nodoc
const $AuthenticatorFailure = _$AuthenticatorFailureTearOff();

/// @nodoc
mixin _$AuthenticatorFailure {
  /// A login failure.
  LoginFailure get failure => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFailure failure) logIn,
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
    required TResult Function(_AuthenticatorFailureLogIn value) logIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatorFailureLogIn value)? logIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenticatorFailureCopyWith<AuthenticatorFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticatorFailureCopyWith<$Res> {
  factory $AuthenticatorFailureCopyWith(AuthenticatorFailure value,
          $Res Function(AuthenticatorFailure) then) =
      _$AuthenticatorFailureCopyWithImpl<$Res>;
  $Res call({LoginFailure failure});

  $LoginFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$AuthenticatorFailureCopyWithImpl<$Res>
    implements $AuthenticatorFailureCopyWith<$Res> {
  _$AuthenticatorFailureCopyWithImpl(this._value, this._then);

  final AuthenticatorFailure _value;
  // ignore: unused_field
  final $Res Function(AuthenticatorFailure) _then;

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
abstract class _$AuthenticatorFailureLogInCopyWith<$Res>
    implements $AuthenticatorFailureCopyWith<$Res> {
  factory _$AuthenticatorFailureLogInCopyWith(_AuthenticatorFailureLogIn value,
          $Res Function(_AuthenticatorFailureLogIn) then) =
      __$AuthenticatorFailureLogInCopyWithImpl<$Res>;
  @override
  $Res call({LoginFailure failure});

  @override
  $LoginFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$AuthenticatorFailureLogInCopyWithImpl<$Res>
    extends _$AuthenticatorFailureCopyWithImpl<$Res>
    implements _$AuthenticatorFailureLogInCopyWith<$Res> {
  __$AuthenticatorFailureLogInCopyWithImpl(_AuthenticatorFailureLogIn _value,
      $Res Function(_AuthenticatorFailureLogIn) _then)
      : super(_value, (v) => _then(v as _AuthenticatorFailureLogIn));

  @override
  _AuthenticatorFailureLogIn get _value =>
      super._value as _AuthenticatorFailureLogIn;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_AuthenticatorFailureLogIn(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as LoginFailure,
    ));
  }
}

/// @nodoc

class _$_AuthenticatorFailureLogIn implements _AuthenticatorFailureLogIn {
  const _$_AuthenticatorFailureLogIn(this.failure);

  @override

  /// A login failure.
  final LoginFailure failure;

  @override
  String toString() {
    return 'AuthenticatorFailure.logIn(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticatorFailureLogIn &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$AuthenticatorFailureLogInCopyWith<_AuthenticatorFailureLogIn>
      get copyWith =>
          __$AuthenticatorFailureLogInCopyWithImpl<_AuthenticatorFailureLogIn>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFailure failure) logIn,
  }) {
    return logIn(failure);
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
    required TResult Function(_AuthenticatorFailureLogIn value) logIn,
  }) {
    return logIn(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatorFailureLogIn value)? logIn,
    required TResult orElse(),
  }) {
    if (logIn != null) {
      return logIn(this);
    }
    return orElse();
  }
}

abstract class _AuthenticatorFailureLogIn implements AuthenticatorFailure {
  const factory _AuthenticatorFailureLogIn(LoginFailure failure) =
      _$_AuthenticatorFailureLogIn;

  @override

  /// A login failure.
  LoginFailure get failure => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AuthenticatorFailureLogInCopyWith<_AuthenticatorFailureLogIn>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$AuthenticatorStateTearOff {
  const _$AuthenticatorStateTearOff();

  _AuthenticatorStateLoading loading() {
    return const _AuthenticatorStateLoading();
  }

  _AuthenticatorStateAuthenticated authenticated() {
    return const _AuthenticatorStateAuthenticated();
  }

  _AuthenticatorStateUnauthenticated unauthenticated() {
    return const _AuthenticatorStateUnauthenticated();
  }

  _AuthenticatorStateFailure failure(AuthenticatorFailure failure) {
    return _AuthenticatorStateFailure(
      failure,
    );
  }
}

/// @nodoc
const $AuthenticatorState = _$AuthenticatorStateTearOff();

/// @nodoc
mixin _$AuthenticatorState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthenticatorFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthenticatorFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticatorStateLoading value) loading,
    required TResult Function(_AuthenticatorStateAuthenticated value)
        authenticated,
    required TResult Function(_AuthenticatorStateUnauthenticated value)
        unauthenticated,
    required TResult Function(_AuthenticatorStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatorStateLoading value)? loading,
    TResult Function(_AuthenticatorStateAuthenticated value)? authenticated,
    TResult Function(_AuthenticatorStateUnauthenticated value)? unauthenticated,
    TResult Function(_AuthenticatorStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticatorStateCopyWith<$Res> {
  factory $AuthenticatorStateCopyWith(
          AuthenticatorState value, $Res Function(AuthenticatorState) then) =
      _$AuthenticatorStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthenticatorStateCopyWithImpl<$Res>
    implements $AuthenticatorStateCopyWith<$Res> {
  _$AuthenticatorStateCopyWithImpl(this._value, this._then);

  final AuthenticatorState _value;
  // ignore: unused_field
  final $Res Function(AuthenticatorState) _then;
}

/// @nodoc
abstract class _$AuthenticatorStateLoadingCopyWith<$Res> {
  factory _$AuthenticatorStateLoadingCopyWith(_AuthenticatorStateLoading value,
          $Res Function(_AuthenticatorStateLoading) then) =
      __$AuthenticatorStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthenticatorStateLoadingCopyWithImpl<$Res>
    extends _$AuthenticatorStateCopyWithImpl<$Res>
    implements _$AuthenticatorStateLoadingCopyWith<$Res> {
  __$AuthenticatorStateLoadingCopyWithImpl(_AuthenticatorStateLoading _value,
      $Res Function(_AuthenticatorStateLoading) _then)
      : super(_value, (v) => _then(v as _AuthenticatorStateLoading));

  @override
  _AuthenticatorStateLoading get _value =>
      super._value as _AuthenticatorStateLoading;
}

/// @nodoc

class _$_AuthenticatorStateLoading implements _AuthenticatorStateLoading {
  const _$_AuthenticatorStateLoading();

  @override
  String toString() {
    return 'AuthenticatorState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthenticatorStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthenticatorFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthenticatorFailure failure)? failure,
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
    required TResult Function(_AuthenticatorStateLoading value) loading,
    required TResult Function(_AuthenticatorStateAuthenticated value)
        authenticated,
    required TResult Function(_AuthenticatorStateUnauthenticated value)
        unauthenticated,
    required TResult Function(_AuthenticatorStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatorStateLoading value)? loading,
    TResult Function(_AuthenticatorStateAuthenticated value)? authenticated,
    TResult Function(_AuthenticatorStateUnauthenticated value)? unauthenticated,
    TResult Function(_AuthenticatorStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AuthenticatorStateLoading implements AuthenticatorState {
  const factory _AuthenticatorStateLoading() = _$_AuthenticatorStateLoading;
}

/// @nodoc
abstract class _$AuthenticatorStateAuthenticatedCopyWith<$Res> {
  factory _$AuthenticatorStateAuthenticatedCopyWith(
          _AuthenticatorStateAuthenticated value,
          $Res Function(_AuthenticatorStateAuthenticated) then) =
      __$AuthenticatorStateAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthenticatorStateAuthenticatedCopyWithImpl<$Res>
    extends _$AuthenticatorStateCopyWithImpl<$Res>
    implements _$AuthenticatorStateAuthenticatedCopyWith<$Res> {
  __$AuthenticatorStateAuthenticatedCopyWithImpl(
      _AuthenticatorStateAuthenticated _value,
      $Res Function(_AuthenticatorStateAuthenticated) _then)
      : super(_value, (v) => _then(v as _AuthenticatorStateAuthenticated));

  @override
  _AuthenticatorStateAuthenticated get _value =>
      super._value as _AuthenticatorStateAuthenticated;
}

/// @nodoc

class _$_AuthenticatorStateAuthenticated
    implements _AuthenticatorStateAuthenticated {
  const _$_AuthenticatorStateAuthenticated();

  @override
  String toString() {
    return 'AuthenticatorState.authenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticatorStateAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthenticatorFailure failure) failure,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthenticatorFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticatorStateLoading value) loading,
    required TResult Function(_AuthenticatorStateAuthenticated value)
        authenticated,
    required TResult Function(_AuthenticatorStateUnauthenticated value)
        unauthenticated,
    required TResult Function(_AuthenticatorStateFailure value) failure,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatorStateLoading value)? loading,
    TResult Function(_AuthenticatorStateAuthenticated value)? authenticated,
    TResult Function(_AuthenticatorStateUnauthenticated value)? unauthenticated,
    TResult Function(_AuthenticatorStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _AuthenticatorStateAuthenticated implements AuthenticatorState {
  const factory _AuthenticatorStateAuthenticated() =
      _$_AuthenticatorStateAuthenticated;
}

/// @nodoc
abstract class _$AuthenticatorStateUnauthenticatedCopyWith<$Res> {
  factory _$AuthenticatorStateUnauthenticatedCopyWith(
          _AuthenticatorStateUnauthenticated value,
          $Res Function(_AuthenticatorStateUnauthenticated) then) =
      __$AuthenticatorStateUnauthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthenticatorStateUnauthenticatedCopyWithImpl<$Res>
    extends _$AuthenticatorStateCopyWithImpl<$Res>
    implements _$AuthenticatorStateUnauthenticatedCopyWith<$Res> {
  __$AuthenticatorStateUnauthenticatedCopyWithImpl(
      _AuthenticatorStateUnauthenticated _value,
      $Res Function(_AuthenticatorStateUnauthenticated) _then)
      : super(_value, (v) => _then(v as _AuthenticatorStateUnauthenticated));

  @override
  _AuthenticatorStateUnauthenticated get _value =>
      super._value as _AuthenticatorStateUnauthenticated;
}

/// @nodoc

class _$_AuthenticatorStateUnauthenticated
    implements _AuthenticatorStateUnauthenticated {
  const _$_AuthenticatorStateUnauthenticated();

  @override
  String toString() {
    return 'AuthenticatorState.unauthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticatorStateUnauthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthenticatorFailure failure) failure,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthenticatorFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticatorStateLoading value) loading,
    required TResult Function(_AuthenticatorStateAuthenticated value)
        authenticated,
    required TResult Function(_AuthenticatorStateUnauthenticated value)
        unauthenticated,
    required TResult Function(_AuthenticatorStateFailure value) failure,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatorStateLoading value)? loading,
    TResult Function(_AuthenticatorStateAuthenticated value)? authenticated,
    TResult Function(_AuthenticatorStateUnauthenticated value)? unauthenticated,
    TResult Function(_AuthenticatorStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _AuthenticatorStateUnauthenticated
    implements AuthenticatorState {
  const factory _AuthenticatorStateUnauthenticated() =
      _$_AuthenticatorStateUnauthenticated;
}

/// @nodoc
abstract class _$AuthenticatorStateFailureCopyWith<$Res> {
  factory _$AuthenticatorStateFailureCopyWith(_AuthenticatorStateFailure value,
          $Res Function(_AuthenticatorStateFailure) then) =
      __$AuthenticatorStateFailureCopyWithImpl<$Res>;
  $Res call({AuthenticatorFailure failure});

  $AuthenticatorFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$AuthenticatorStateFailureCopyWithImpl<$Res>
    extends _$AuthenticatorStateCopyWithImpl<$Res>
    implements _$AuthenticatorStateFailureCopyWith<$Res> {
  __$AuthenticatorStateFailureCopyWithImpl(_AuthenticatorStateFailure _value,
      $Res Function(_AuthenticatorStateFailure) _then)
      : super(_value, (v) => _then(v as _AuthenticatorStateFailure));

  @override
  _AuthenticatorStateFailure get _value =>
      super._value as _AuthenticatorStateFailure;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_AuthenticatorStateFailure(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AuthenticatorFailure,
    ));
  }

  @override
  $AuthenticatorFailureCopyWith<$Res> get failure {
    return $AuthenticatorFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_AuthenticatorStateFailure implements _AuthenticatorStateFailure {
  const _$_AuthenticatorStateFailure(this.failure);

  @override
  final AuthenticatorFailure failure;

  @override
  String toString() {
    return 'AuthenticatorState.failure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticatorStateFailure &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$AuthenticatorStateFailureCopyWith<_AuthenticatorStateFailure>
      get copyWith =>
          __$AuthenticatorStateFailureCopyWithImpl<_AuthenticatorStateFailure>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthenticatorFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthenticatorFailure failure)? failure,
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
    required TResult Function(_AuthenticatorStateLoading value) loading,
    required TResult Function(_AuthenticatorStateAuthenticated value)
        authenticated,
    required TResult Function(_AuthenticatorStateUnauthenticated value)
        unauthenticated,
    required TResult Function(_AuthenticatorStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatorStateLoading value)? loading,
    TResult Function(_AuthenticatorStateAuthenticated value)? authenticated,
    TResult Function(_AuthenticatorStateUnauthenticated value)? unauthenticated,
    TResult Function(_AuthenticatorStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _AuthenticatorStateFailure implements AuthenticatorState {
  const factory _AuthenticatorStateFailure(AuthenticatorFailure failure) =
      _$_AuthenticatorStateFailure;

  AuthenticatorFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthenticatorStateFailureCopyWith<_AuthenticatorStateFailure>
      get copyWith => throw _privateConstructorUsedError;
}
