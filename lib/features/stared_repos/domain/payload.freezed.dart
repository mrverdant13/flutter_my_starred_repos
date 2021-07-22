// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PayloadTearOff {
  const _$PayloadTearOff();

  _Payload<D, W> call<D, W>(D data) {
    return _Payload<D, W>(
      data,
    );
  }

  _PayloadWithWarning<D, W> withWarning<D, W>(
      {required D data, required W warning}) {
    return _PayloadWithWarning<D, W>(
      data: data,
      warning: warning,
    );
  }
}

/// @nodoc
const $Payload = _$PayloadTearOff();

/// @nodoc
mixin _$Payload<D, W> {
  D get data => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(D data) $default, {
    required TResult Function(D data, W warning) withWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Payload<D, W> value) $default, {
    required TResult Function(_PayloadWithWarning<D, W> value) withWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Payload<D, W> value)? $default, {
    TResult Function(_PayloadWithWarning<D, W> value)? withWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PayloadCopyWith<D, W, Payload<D, W>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadCopyWith<D, W, $Res> {
  factory $PayloadCopyWith(
          Payload<D, W> value, $Res Function(Payload<D, W>) then) =
      _$PayloadCopyWithImpl<D, W, $Res>;
  $Res call({D data});
}

/// @nodoc
class _$PayloadCopyWithImpl<D, W, $Res>
    implements $PayloadCopyWith<D, W, $Res> {
  _$PayloadCopyWithImpl(this._value, this._then);

  final Payload<D, W> _value;
  // ignore: unused_field
  final $Res Function(Payload<D, W>) _then;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as D,
    ));
  }
}

/// @nodoc
abstract class _$PayloadCopyWith<D, W, $Res>
    implements $PayloadCopyWith<D, W, $Res> {
  factory _$PayloadCopyWith(
          _Payload<D, W> value, $Res Function(_Payload<D, W>) then) =
      __$PayloadCopyWithImpl<D, W, $Res>;
  @override
  $Res call({D data});
}

/// @nodoc
class __$PayloadCopyWithImpl<D, W, $Res>
    extends _$PayloadCopyWithImpl<D, W, $Res>
    implements _$PayloadCopyWith<D, W, $Res> {
  __$PayloadCopyWithImpl(
      _Payload<D, W> _value, $Res Function(_Payload<D, W>) _then)
      : super(_value, (v) => _then(v as _Payload<D, W>));

  @override
  _Payload<D, W> get _value => super._value as _Payload<D, W>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_Payload<D, W>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as D,
    ));
  }
}

/// @nodoc

class _$_Payload<D, W> extends _Payload<D, W> {
  const _$_Payload(this.data) : super._();

  @override
  final D data;

  @override
  String toString() {
    return 'Payload<$D, $W>(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Payload<D, W> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$PayloadCopyWith<D, W, _Payload<D, W>> get copyWith =>
      __$PayloadCopyWithImpl<D, W, _Payload<D, W>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(D data) $default, {
    required TResult Function(D data, W warning) withWarning,
  }) {
    return $default(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Payload<D, W> value) $default, {
    required TResult Function(_PayloadWithWarning<D, W> value) withWarning,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Payload<D, W> value)? $default, {
    TResult Function(_PayloadWithWarning<D, W> value)? withWarning,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Payload<D, W> extends Payload<D, W> {
  const factory _Payload(D data) = _$_Payload<D, W>;
  const _Payload._() : super._();

  @override
  D get data => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PayloadCopyWith<D, W, _Payload<D, W>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$PayloadWithWarningCopyWith<D, W, $Res>
    implements $PayloadCopyWith<D, W, $Res> {
  factory _$PayloadWithWarningCopyWith(_PayloadWithWarning<D, W> value,
          $Res Function(_PayloadWithWarning<D, W>) then) =
      __$PayloadWithWarningCopyWithImpl<D, W, $Res>;
  @override
  $Res call({D data, W warning});
}

/// @nodoc
class __$PayloadWithWarningCopyWithImpl<D, W, $Res>
    extends _$PayloadCopyWithImpl<D, W, $Res>
    implements _$PayloadWithWarningCopyWith<D, W, $Res> {
  __$PayloadWithWarningCopyWithImpl(_PayloadWithWarning<D, W> _value,
      $Res Function(_PayloadWithWarning<D, W>) _then)
      : super(_value, (v) => _then(v as _PayloadWithWarning<D, W>));

  @override
  _PayloadWithWarning<D, W> get _value =>
      super._value as _PayloadWithWarning<D, W>;

  @override
  $Res call({
    Object? data = freezed,
    Object? warning = freezed,
  }) {
    return _then(_PayloadWithWarning<D, W>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as D,
      warning: warning == freezed
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as W,
    ));
  }
}

/// @nodoc

class _$_PayloadWithWarning<D, W> extends _PayloadWithWarning<D, W> {
  const _$_PayloadWithWarning({required this.data, required this.warning})
      : super._();

  @override
  final D data;
  @override
  final W warning;

  @override
  String toString() {
    return 'Payload<$D, $W>.withWarning(data: $data, warning: $warning)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PayloadWithWarning<D, W> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.warning, warning) ||
                const DeepCollectionEquality().equals(other.warning, warning)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(warning);

  @JsonKey(ignore: true)
  @override
  _$PayloadWithWarningCopyWith<D, W, _PayloadWithWarning<D, W>> get copyWith =>
      __$PayloadWithWarningCopyWithImpl<D, W, _PayloadWithWarning<D, W>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(D data) $default, {
    required TResult Function(D data, W warning) withWarning,
  }) {
    return withWarning(data, warning);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
    required TResult orElse(),
  }) {
    if (withWarning != null) {
      return withWarning(data, warning);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Payload<D, W> value) $default, {
    required TResult Function(_PayloadWithWarning<D, W> value) withWarning,
  }) {
    return withWarning(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Payload<D, W> value)? $default, {
    TResult Function(_PayloadWithWarning<D, W> value)? withWarning,
    required TResult orElse(),
  }) {
    if (withWarning != null) {
      return withWarning(this);
    }
    return orElse();
  }
}

abstract class _PayloadWithWarning<D, W> extends Payload<D, W> {
  const factory _PayloadWithWarning({required D data, required W warning}) =
      _$_PayloadWithWarning<D, W>;
  const _PayloadWithWarning._() : super._();

  @override
  D get data => throw _privateConstructorUsedError;
  W get warning => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PayloadWithWarningCopyWith<D, W, _PayloadWithWarning<D, W>> get copyWith =>
      throw _privateConstructorUsedError;
}
